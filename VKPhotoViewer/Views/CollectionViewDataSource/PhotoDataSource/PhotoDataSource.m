//
//  PhotoDataSource.m
//  VKPhotoViewer
//
//  Created by Svetlana on 10.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PhotoDataSource.h"
#import "PhotoCell.h"
#import "Photo.h"
#import "AppCache.h"

static NSString *const CELL_ID = @"PHOTO_CELL";

@interface PhotoDataSource ()

@property (nonatomic) NSArray *photos;
@property (nonatomic) Photo *selectedPhoto;
@property (nonatomic) NSCache *cache;

@end

@implementation PhotoDataSource

- (instancetype)initWithPhotos:(NSArray *)photos selectedPhoto:(Photo *)selectedPhoto {
    self = [super init];
    if (self) {
        self.photos = photos;
        self.selectedPhoto = selectedPhoto;
        self.cache = [NSCache new];
    }
    return self;
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (!cell) {
        cell = [PhotoCell new];
    }
    
    Photo *photo = self.photos[indexPath.item];
    cell.dateLabel.text = [self formatDate:photo.date];

    NSString *cacheKey = [NSString stringWithFormat:@"%li", indexPath.item];
    
    if ([[AppCache sharedInstance] objectForKey:cacheKey]) {
        cell.imageView.image = [[AppCache sharedInstance] objectForKey:cacheKey];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.photo]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
                if (image != nil) [[AppCache sharedInstance] saveObject:image forKey:cacheKey];
            });
        });
    }
    
    return cell;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    return [formatter stringFromDate:date];
}

@end

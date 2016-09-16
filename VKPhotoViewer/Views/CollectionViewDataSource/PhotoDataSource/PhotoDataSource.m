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

@end

@implementation PhotoDataSource

- (instancetype)initWithPhotos:(NSArray *)photos {
    self = [super init];
    if (self) {
        self.photos = photos;
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
    
    NSString *cacheKey = [NSString stringWithFormat:@"%li", indexPath.item];
    
    [cell.activityIndicator stopAnimating];
    
    Photo *photo = self.photos[indexPath.item];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *dateText = [self formatDate:photo.date];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.dateLabel.text = dateText;
        });
    });
    
    [cell.activityIndicator startAnimating];
    
    if ([[AppCache sharedInstance] objectForKey:cacheKey]) {
        [cell.activityIndicator stopAnimating];
        cell.imageView.image = [[AppCache sharedInstance] objectForKey:cacheKey];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.photo]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.activityIndicator stopAnimating];
                cell.imageView.image = image;
                if (image != nil) [[AppCache sharedInstance] saveObject:image forKey:cacheKey];
            });
        });
    }
    cell.activityIndicator.hidesWhenStopped = YES;

    return cell;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    return [formatter stringFromDate:date];
}

@end

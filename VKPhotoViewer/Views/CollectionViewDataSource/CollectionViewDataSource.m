//
//  CollectionViewDataSource.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "CollectionViewDataSource.h"
#import "ThumbnailCell.h"
#import "Photo.h"
#import "AppCache.h"

static NSString *const CELL_ID = @"THUMBNAIL_CELL";

@interface CollectionViewDataSource ()

@property (nonatomic) NSArray *photoArray;

@end

@implementation CollectionViewDataSource

- (instancetype)initWithPhotoArray:(NSArray *)photoArray {
    self = [super init];
    if (self) {
        self.photoArray = photoArray;
    }
    return self;
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.photoArray == nil) ? 0 : self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (!cell) {
        cell = [ThumbnailCell new];
    }
    
    [cell.activityIndicator stopAnimating];
    
    Photo *photo = self.photoArray[indexPath.item];
    NSString *cacheKey = [NSString stringWithFormat:@"%li", indexPath.item];
    
    [cell.activityIndicator startAnimating];
    
    if ([[AppCache sharedInstance] objectForKey:cacheKey]) {
        [cell.activityIndicator stopAnimating];
        cell.imageView.image = [[AppCache sharedInstance] objectForKey:cacheKey];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.thumbnail]]];
            
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

@end

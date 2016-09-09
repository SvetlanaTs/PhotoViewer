//
//  CollectionViewDataSource.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "CollectionViewDataSource.h"
#import "Photo.h"
#import "PhotoCell.h"

static NSString *const CELL_ID = @"PHOTO_CELL";

@interface CollectionViewDataSource ()

@property (nonatomic) NSArray *photoArray;
@property (nonatomic) NSCache *cache;

@end

@implementation CollectionViewDataSource

- (instancetype)initWithPhotoArray:(NSArray *)photoArray {
    self = [super init];
    if (self) {
        self.photoArray = photoArray;
        self.cache = [NSCache new];
    }
    return self;
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (!cell) {
        cell = [PhotoCell new];
    }
    
    Photo *photo = self.photoArray[indexPath.row];
    
    NSString *cacheKey = [NSString stringWithFormat:@"%li", indexPath.row];
    
    if ([self.cache objectForKey:cacheKey]) {
        cell.imageView.image = [self.cache objectForKey:cacheKey];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.thumbnail]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
                if (image != nil) [self.cache setObject:image forKey:cacheKey];
            });
        });
    }
    
    return cell;
}


@end

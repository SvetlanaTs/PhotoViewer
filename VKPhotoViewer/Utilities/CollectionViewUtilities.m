//
//  CollectionViewUtilities.m
//  VKPhotoViewer
//
//  Created by Svetlana on 11.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "CollectionViewUtilities.h"

@implementation CollectionViewUtilities

+ (void)collectionView:(UICollectionView *)collectionView itemSizeOfFlowLayout:(UICollectionViewFlowLayout *)flowLayout withDefaultSpace:(CGFloat)defaultSpace numberOfItemsPerRow:(CGFloat)numberOfItemsPerRow {
    CGFloat width = (collectionView.bounds.size.width - (defaultSpace * (numberOfItemsPerRow + 1))) / numberOfItemsPerRow;
    flowLayout.itemSize = CGSizeMake(width, width);
    flowLayout.minimumLineSpacing = defaultSpace;
    flowLayout.minimumInteritemSpacing = defaultSpace;
    
    collectionView.contentInset = UIEdgeInsetsMake(defaultSpace, defaultSpace, defaultSpace, defaultSpace);
}

@end

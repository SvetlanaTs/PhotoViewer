//
//  CollectionViewUtilities.h
//  VKPhotoViewer
//
//  Created by Svetlana on 11.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionViewUtilities : NSObject

+ (void)collectionView:(UICollectionView *)collectionView itemSizeOfFlowLayout:(UICollectionViewFlowLayout *)flowLayout withDefaultSpace:(CGFloat)defaultSpace numberOfItemsPerRow:(CGFloat)numberOfItemsPerRow;

@end

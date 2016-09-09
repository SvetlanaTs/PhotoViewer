//
//  CollectionViewDataSource.h
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithPhotoArray:(NSArray *)photoArray;

@end

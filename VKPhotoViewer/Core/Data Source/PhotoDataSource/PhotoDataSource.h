//
//  PhotoDataSource.h
//  VKPhotoViewer
//
//  Created by Svetlana on 10.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithPhotos:(NSArray *)photos;

@end

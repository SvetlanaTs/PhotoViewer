//
//  PhotoViewController.h
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

@interface PhotoViewController : UIViewController

@property (nonatomic) NSArray *photos;
@property (nonatomic) Photo *photo;
@property (nonatomic) NSIndexPath *indexPath;

@end

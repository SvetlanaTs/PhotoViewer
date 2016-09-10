//
//  Photo.h
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic) NSNumber *photoId;
@property (nonatomic) NSString *photo;
@property (nonatomic) NSString *thumbnail;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *text;

@end

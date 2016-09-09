//
//  PhotoMapper.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PhotoMapper.h"
#import "Photo.h"

static NSString *const PHOTO_SIZE = @"photo_604";
static NSString *const THUMBNAIL_SIZE = @"photo_130";

@implementation PhotoMapper

- (Photo *)mapPhotoFromDictionary:(NSDictionary *)dict {
    Photo *photo = [Photo new];
    photo.photoId = dict[@"id"];
    photo.photo = dict[PHOTO_SIZE];
    photo.thumbnail = dict[THUMBNAIL_SIZE];
    
    return photo;
}

@end

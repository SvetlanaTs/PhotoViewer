//
//  PhotoMapper.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PhotoMapper.h"
#import "Photo.h"

static NSString *const PHOTO_SIZE = @"photo_1280";
static NSString *const THUMBNAIL_SIZE = @"photo_604";

@implementation PhotoMapper

- (Photo *)mapPhotoFromDictionary:(NSDictionary *)dict {
    Photo *photo = [Photo new];
    
    if ([dict[@"id"] isKindOfClass:[NSNumber class]])               photo.photoId = dict[@"id"];
    if ([dict[PHOTO_SIZE] isKindOfClass:[NSString class]])          photo.photo = dict[PHOTO_SIZE];
    if ([dict[THUMBNAIL_SIZE] isKindOfClass:[NSString class]])      photo.thumbnail = dict[THUMBNAIL_SIZE];
    if ([dict[@"text"] isKindOfClass:[NSString class]])             photo.text = dict[@"text"];
    
    if ([dict[@"date"] isKindOfClass:[NSNumber class]]) {
        NSNumber *interval = dict[@"date"];
        photo.date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    }
    
    return photo;
}

@end
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
    photo.photoId = dict[@"id"];
    photo.photo = dict[PHOTO_SIZE];
    photo.thumbnail = dict[THUMBNAIL_SIZE];
    photo.text = dict[@"text"];
    
    NSNumber *interval = dict[@"date"];
    photo.date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    
    return photo;
}

@end

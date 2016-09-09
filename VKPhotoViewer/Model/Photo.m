//
//  Photo.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithId:(NSNumber *)photoId photo:(NSString *)photo thumbnail:(NSString *)thumbnail {
    self = [super init];
    if (self) {
        self.photoId = photoId;
        self.photo = photo;
        self.thumbnail = thumbnail;
    }
    return self;
}

@end

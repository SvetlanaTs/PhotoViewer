//
//  APIClient.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "APIClient.h"
#import "VKPhotoService.h"
#import "PhotoMapper.h"
#import "Photo.h"

@implementation APIClient

+ (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion {
    PhotoMapper *mapper = [PhotoMapper new];

    [VKPhotoService getPhotoListWithCompletion:^(NSArray *photos) {
        NSMutableArray *photoArray = [NSMutableArray new];
        for (NSDictionary *dict in photos) {
            Photo *photo = [mapper mapPhotoFromDictionary:dict];
            [photoArray addObject:photo];
        }
        NSArray *photoObjectArray = [NSArray arrayWithArray:photoArray];
        completion(photoObjectArray);
    }];
}

@end

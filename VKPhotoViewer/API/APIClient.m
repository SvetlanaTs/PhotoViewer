//
//  APIClient.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "APIClient.h"
#import "VKPhotoService.h"

@implementation APIClient

+ (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion {
    [VKPhotoService getPhotoListWithCompletion:^(NSArray *photos) {
        completion(photos);
    }];
}

@end

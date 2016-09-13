//
//  VKPhotoService.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "VKPhotoService.h"
#import <VK-ios-sdk/VKSdk.h>

static NSString *const VK_PHOTOS_METHOD = @"photos.getAll";

@implementation VKPhotoService

+ (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion {
    VKRequest *photoRequest = [VKRequest requestWithMethod:VK_PHOTOS_METHOD parameters:@{VK_API_COUNT : @"200"}];
    
    [photoRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *photos = [NSArray arrayWithArray:response.json[@"items"]];
        completion(photos);
    } errorBlock:^(NSError *error) {
        if (error.code != VK_API_ERROR)
            [error.vkError.request repeat];
        else
            NSLog(@"error:\n %@", error.localizedDescription);
    }];
}

@end
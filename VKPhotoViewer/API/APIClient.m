//
//  APIClient.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "APIClient.h"
#import "PhotoService.h"

@implementation APIClient

+ (void)getPhotoListWithSuccess:(void (^)(NSArray *photos))success
                        failure:(void(^)(NSError *error))failure {

    [PhotoService getPhotoListFromVKRequestWithSuccess:^(NSArray *photos) {
        success(photos);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getPhotoListFromURLSession {
    
}



@end

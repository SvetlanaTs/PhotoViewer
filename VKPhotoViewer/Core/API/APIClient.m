//
//  APIClient.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "APIClient.h"
#import "VKLoginService.h"
#import "VKPhotoService.h"
#import "PhotoMapper.h"
#import "Photo.h"

@implementation APIClient {
    VKLoginService *loginService;
    VKPhotoService *photoService;
    PhotoMapper *photoMapper;
}

+ (APIClient *)sharedInstance {
    static APIClient *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [APIClient new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        loginService = [VKLoginService new];
        photoService = [VKPhotoService new];
        photoMapper = [PhotoMapper new];
    }
    return self;
}

- (void)authorize {
    [loginService authorize];
}

- (void)logout {
    [loginService logout];
}

- (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion {
    [photoService getPhotoListWithCompletion:^(NSArray *photos) {
        NSMutableArray *photoArray = [NSMutableArray new];
        for (NSDictionary *dict in photos) {
            Photo *photo = [photoMapper mapPhotoFromDictionary:dict];
            [photoArray addObject:photo];
        }
        NSArray *photoObjectArray = [NSArray arrayWithArray:photoArray];
        completion(photoObjectArray);
    }];
}

@end

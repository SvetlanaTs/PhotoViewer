//
//  LoginService.m
//  VKPhotoViewer
//
//  Created by Svetlana on 08.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "LoginService.h"
#import <VK-ios-sdk/VKSdk.h>

static NSString *const VK_APP_ID = @"5597588";
static NSArray *SCOPE = nil;

@implementation LoginService {
    VKLoginService *vkLoginService;
}

- (instancetype)initWithAppID:(NSString *)appId scope:(NSArray *)scope viewController:(UIViewController *)vc {
    self = [super init];
    
    if (self) {
        SCOPE = @[VK_PER_PHOTOS];

        vkLoginService = [[VKLoginService alloc] initWithAppID:VK_APP_ID scope:SCOPE];
        vkLoginService.viewController = vc;
    }
    return self;
}

- (instancetype)initWithViewController:(UIViewController *)vc {
    return [self initWithAppID:VK_APP_ID scope:SCOPE viewController:vc];
}

- (void)authorize {
    [vkLoginService authorize:SCOPE];
}

+ (void)logout {
    [VKLoginService logout];
}

@end

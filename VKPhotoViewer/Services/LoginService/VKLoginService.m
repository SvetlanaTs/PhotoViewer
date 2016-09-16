//
//  VKLoginService.m
//  VKPhotoViewer
//
//  Created by Svetlana on 08.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "VKLoginService.h"
#import <VK-ios-sdk/VKSdk.h>

static NSString *const VK_APP_ID = @"5597588";
static NSArray *SCOPE = nil;

@interface VKLoginService () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation VKLoginService

- (instancetype)init {
    SCOPE = @[VK_PER_PHOTOS];
    return [self initWithAppID:VK_APP_ID scope:SCOPE];
}

- (instancetype)initWithAppID:(NSString *)appId scope:(NSArray *)scope {
    self = [super init];
    
    if (self) {
        VKSdk *sdkInstance = [VKSdk initializeWithAppId:appId];
        [sdkInstance registerDelegate:self];
        sdkInstance.uiDelegate = self;
        
        [VKSdk wakeUpSession:scope completeBlock:^(VKAuthorizationState state, NSError *error) {
            if (state == VKAuthorizationAuthorized) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PerformStartActionNotification" object:nil];
            } else if (error) {
                NSLog(@"error: %@", error.localizedDescription);
            }
        }];
    }
    
    return self;
}

- (void)authorize {
    [VKSdk authorize:SCOPE];
}

- (void)logout {
    [VKSdk forceLogout];
}

#pragma mark - VK SDK Delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissViewControllerAnimated" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PerformStartActionNotification" object:nil];
    } else if (result.error) {
        NSLog(@"result: %@", result.error.localizedDescription);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"vkSdkUserAuthorizationFailed");
}

#pragma mark - VK SDK UI Delegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentViewController" object:controller];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"captchaError: %@", captchaError.errorMessage);
}

@end

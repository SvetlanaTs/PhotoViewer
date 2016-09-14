//
//  VKLoginService.m
//  VKPhotoViewer
//
//  Created by Svetlana on 08.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "VKLoginService.h"
#import <VK-ios-sdk/VKSdk.h>

@interface VKLoginService () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation VKLoginService

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

- (void)authorize:(NSArray *)scope {
    [VKSdk authorize:scope];
}

+ (void)logout {
    [VKSdk forceLogout];
}

#pragma mark - VK SDK Delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
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
    [self.viewController presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"captchaError: %@", captchaError.errorMessage);
}

@end

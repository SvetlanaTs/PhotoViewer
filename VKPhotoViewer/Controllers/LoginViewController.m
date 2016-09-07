//
//  LoginViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 05.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "LoginViewController.h"
#import "PreviewViewController.h"
#import "ActionButton.h"
#import <VK-ios-sdk/VKSdk.h>

static CGFloat const BUTTON_WIDTH = 90.0f;
static CGFloat const BUTTON_HEIGHT = 40.0f;
static NSString *const VK_APP_ID = @"5597588";
static NSArray *SCOPE = nil;
static NSString *const BUTTON_TITLE = @"Authorize";

@interface LoginViewController () <VKSdkDelegate, VKSdkUIDelegate, ActionButtonDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeVKSdk];
    [self addLoginView];
}

- (void)initializeVKSdk {
    SCOPE = @[VK_PER_PHOTOS];
    
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:VK_APP_ID];
    [sdkInstance registerDelegate:self];
    sdkInstance.uiDelegate = self;
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            [self startWorking];
        } else if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (void)addLoginView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect btnFrame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2,
                                   self.view.frame.size.height/2 - BUTTON_HEIGHT/2,
                                   BUTTON_WIDTH,
                                   BUTTON_HEIGHT);
    
    ActionButton *loginButton = [[ActionButton alloc] initWithFrame:btnFrame title:BUTTON_TITLE];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

#pragma mark - Authorize with VK

- (void)performAction:(id)sender {
    [VKSdk authorize:SCOPE];
}

#pragma mark - Open Preview View

- (void)startWorking {
    PreviewViewController *previewViewController = [PreviewViewController new];
    [self presentViewController:previewViewController animated:YES completion:nil];
}

#pragma mark - VK SDK Delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self startWorking];
    } else if (result.error) {
        NSLog(@"result: %@", result.error.localizedDescription);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"vkSdkUserAuthorizationFailed");
}

#pragma mark - VK SDK UI Delegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"captchaError: %@", captchaError.errorMessage);
}

@end

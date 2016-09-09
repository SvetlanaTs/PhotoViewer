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
#import "LoginService.h"

static CGFloat const BUTTON_WIDTH = 90.0f;
static CGFloat const BUTTON_HEIGHT = 40.0f;
static NSString *const BUTTON_TITLE = @"Authorize";

@interface LoginViewController () <ActionButtonDelegate>

@end

@implementation LoginViewController {
    LoginService *loginService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeLoginService];
    [self addLoginView];
}

- (void)initializeLoginService {
    loginService = [[LoginService alloc] initWithViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startWorking) name:@"PerformStartActionNotification" object:nil];
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

#pragma mark - VK Login Service

- (void)startWorking {
    PreviewViewController *previewViewController = [PreviewViewController new];
    [self presentViewController:previewViewController animated:YES completion:nil];
}

#pragma mark - Authorize

- (void)performAction:(id)sender {
    [loginService authorize];
}

@end

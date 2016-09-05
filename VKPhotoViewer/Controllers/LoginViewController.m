//
//  LoginViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 05.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "LoginViewController.h"

static CGFloat const BUTTON_WIDTH = 90.0f;
static CGFloat const BUTTON_HEIGHT = 40.0f;

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLoginView];
}

- (void)addLoginView {
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2,
                                   self.view.frame.size.height/2 - BUTTON_HEIGHT/2,
                                   BUTTON_WIDTH,
                                   BUTTON_HEIGHT);
    [loginButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(authorize:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)authorize:(id)sender {
    NSLog(@"authorize");
}

@end

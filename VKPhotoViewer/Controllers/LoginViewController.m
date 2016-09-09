//
//  LoginViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 05.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "LoginViewController.h"
#import "PreviewViewController.h"
#import "LoginService.h"

static NSString *const SEGUE_ID = @"START_WORKING";

@interface LoginViewController ()
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController {
    LoginService *loginService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeLoginService];
}

- (void)initializeLoginService {
    loginService = [[LoginService alloc] initWithViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startWorking) name:@"PerformStartActionNotification" object:nil];
}

- (void)startWorking {
    [self performSegueWithIdentifier:SEGUE_ID sender:self];
}

- (IBAction)login:(id)sender {
    [loginService authorize];
}

@end

//
//  LoginViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 05.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "LoginViewController.h"
#import "PreviewViewController.h"
#import "APIClient.h"

static NSString *const SEGUE_ID = @"START_WORKING";

@interface LoginViewController ()
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeLoginService];
}

#pragma mark - Login Service

- (void)initializeLoginService {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startWorking) name:@"PerformStartActionNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissViewController) name:@"DismissViewController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentViewController:) name:@"PresentViewController" object:nil];
}

- (void)startWorking {
    [self performSegueWithIdentifier:SEGUE_ID sender:self];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentViewController:(NSNotification *)notification {
    [self presentViewController:notification.object animated:YES completion:nil];
}

#pragma mark - Login

- (IBAction)login:(id)sender {
    [[APIClient sharedInstance] authorize];
}

@end

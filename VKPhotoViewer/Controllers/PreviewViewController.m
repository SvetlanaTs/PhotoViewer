//
//  PreviewViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 06.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PreviewViewController.h"
#import <VK-ios-sdk/VKSdk.h>

static CGFloat const BUTTON_WIDTH = 90.0f;
static CGFloat const BUTTON_HEIGHT = 40.0f;

@interface PreviewViewController ()

@end

@implementation PreviewViewController {
    UICollectionView *previewCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPreviewView];
}

- (void)addPreviewView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(0.0f,
                                   16.0f,
                                   BUTTON_WIDTH,
                                   BUTTON_HEIGHT);
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)logout:(id)sender {
    [VKSdk forceLogout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

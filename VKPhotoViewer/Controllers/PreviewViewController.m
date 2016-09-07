//
//  PreviewViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 06.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PreviewViewController.h"
#import <VK-ios-sdk/VKSdk.h>
#import "ActionButton.h"

static CGFloat const BUTTON_WIDTH = 90.0f;
static CGFloat const BUTTON_HEIGHT = 40.0f;
static NSString *const BUTTON_TITLE = @"Logout";

@interface PreviewViewController () <ActionButtonDelegate>

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
    
    CGRect btnFrame = CGRectMake(0.0f,
                       16.0f,
                       BUTTON_WIDTH,
                       BUTTON_HEIGHT);
    
    ActionButton *logoutButton = [[ActionButton alloc] initWithFrame:btnFrame title:BUTTON_TITLE];
    logoutButton.delegate = self;
    [self.view addSubview:logoutButton];
}

#pragma mark - Action Button Delegate

- (void)performAction:(id)sender {
    [VKSdk forceLogout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

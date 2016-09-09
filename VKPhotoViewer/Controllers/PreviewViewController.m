//
//  PreviewViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 06.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PreviewViewController.h"
#import "LoginService.h"

static NSString *const VK_PHOTOS_METHOD = @"photos.getAll";

@interface PreviewViewController ()
- (IBAction)logout:(id)sender;

@end

@implementation PreviewViewController {
    UICollectionView *previewCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)logout:(id)sender {
    [LoginService logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

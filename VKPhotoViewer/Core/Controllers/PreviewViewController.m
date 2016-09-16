//
//  PreviewViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 06.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PreviewViewController.h"
#import "APIClient.h"
#import "PreviewDataSource.h"
#import "PhotoViewController.h"
#import "CollectionViewUtilities.h"

static NSString *const SEGUE_ID = @"SHOW_PHOTO";
static CGFloat const DEFAULT_SPACE = 8.0f;
static CGFloat const NUMBER_OF_ITEMS_PER_ROW = 3;
static NSString *const INFO_TEXT = @"No Data Available";

@interface PreviewViewController () <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PreviewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) NSArray *photoObjects;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)logout:(id)sender;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotoList];
}

#pragma mark - Photo List

- (void)getPhotoList {
    [[APIClient sharedInstance] getPhotoListWithCompletion:^(NSArray *photos) {
        if (photos == nil) {
            self.infoLabel.hidden = NO;
            self.infoLabel.text = INFO_TEXT;
        } else {
            self.photoObjects = photos;
            [self showPhotoObjectsInCollectionView];
        }
    }];
}

- (void)showPhotoObjectsInCollectionView {
    [self getDataSource];
    [CollectionViewUtilities collectionView:self.collectionView itemSizeOfFlowLayout:self.flowLayout withDefaultSpace:DEFAULT_SPACE numberOfItemsPerRow:NUMBER_OF_ITEMS_PER_ROW];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - Collection View Data Source

- (void)getDataSource {
    self.dataSource = [[PreviewDataSource alloc] initWithPhotoArray:self.photoObjects];
    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:SEGUE_ID sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGUE_ID]) {
        PhotoViewController *photoViewController = segue.destinationViewController;
        photoViewController.photos = self.photoObjects;
        photoViewController.indexPath = self.selectedIndexPath;
    }
}

#pragma mark - Logout

- (IBAction)logout:(id)sender {
    [[APIClient sharedInstance] logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

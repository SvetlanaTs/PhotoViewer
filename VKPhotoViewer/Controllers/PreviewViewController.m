//
//  PreviewViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 06.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PreviewViewController.h"
#import "LoginService.h"
#import "APIClient.h"
#import "PhotoMapper.h"
#import "Photo.h"
#import "CollectionViewDataSource.h"
#import "PhotoViewController.h"

static NSString *const SEGUE_ID = @"SHOW_PHOTO";
static CGFloat const DEFAULT_SPACE = 8.0f;
static CGFloat const NUMBER_OF_ITEMS_PER_ROW = 3;

@interface PreviewViewController () <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) NSArray *photoObjects;
@property (nonatomic) Photo *photoToPass;

- (IBAction)logout:(id)sender;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotoList];
}

#pragma mark - Photo List

- (void)getPhotoList {
    [APIClient getPhotoListWithSuccess:^(NSArray *photos) {
        self.photoObjects = [self getPhotoObjectsFromAPIArray:photos];
        [self showPhotoObjectsInCollectionView];
    } failure:^(NSError *error) {
        NSLog(@"error:\n %@", error.localizedDescription);
    }];
}

- (NSMutableArray *)getPhotoObjectsFromAPIArray:(NSArray *)APIArray {
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in APIArray) {
        Photo *photo = [self getPhoto:dict];
        [array addObject:photo];
    }
    return array;
}

- (Photo *)getPhoto:(NSDictionary *)dictionary {
    PhotoMapper *mapper = [PhotoMapper new];
    return [mapper mapPhotoFromDictionary:dictionary];
}

- (void)showPhotoObjectsInCollectionView {
    [self getDataSource];
    [self getPhotoImageSize];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - Collection View Data Source

- (void)getDataSource {
    self.dataSource = [[CollectionViewDataSource alloc] initWithPhotoArray:self.photoObjects];
    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.photoToPass = self.photoObjects[indexPath.row];
    [self performSegueWithIdentifier:SEGUE_ID sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGUE_ID]) {
        PhotoViewController *photoViewController = segue.destinationViewController;
        photoViewController.photo = self.photoToPass;
        photoViewController.photos = self.photoObjects;
    }
}

#pragma mark - Photo Image Size

- (void)getPhotoImageSize {
    CGFloat width = (self.collectionView.frame.size.width - (DEFAULT_SPACE * (NUMBER_OF_ITEMS_PER_ROW + 1))) / NUMBER_OF_ITEMS_PER_ROW;
    self.flowLayout.itemSize = CGSizeMake(width, width);
    self.flowLayout.minimumLineSpacing = DEFAULT_SPACE;
    self.flowLayout.minimumInteritemSpacing = DEFAULT_SPACE;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(DEFAULT_SPACE, DEFAULT_SPACE, DEFAULT_SPACE, DEFAULT_SPACE);
}

#pragma mark - Logout

- (IBAction)logout:(id)sender {
    [LoginService logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

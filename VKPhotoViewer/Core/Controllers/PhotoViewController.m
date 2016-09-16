//
//  PhotoViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoDataSource.h"
#import "CollectionViewUtilities.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSource];
    [self centerPhotoOnScreen];
}

- (void)centerPhotoOnScreen {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CollectionViewUtilities collectionView:self.collectionView centerItemOfFlowLayout:self.flowLayout atIndexPath:self.indexPath];
    });
}

#pragma mark - Collection View Data Source

- (void)getDataSource {
    self.dataSource = [[PhotoDataSource alloc] initWithPhotos:self.photos];
    self.collectionView.dataSource = self.dataSource;
}

@end

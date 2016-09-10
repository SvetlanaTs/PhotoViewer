//
//  PhotoViewController.m
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photo.h"
#import "PhotoDataSource.h"

@interface PhotoViewController () <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *dataSource;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view layoutIfNeeded];
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

    dispatch_async(dispatch_get_main_queue(), ^{

        [self.collectionView reloadData];
    });


}

#pragma mark - Collection View Data Source

- (void)getDataSource {
    self.dataSource = [[PhotoDataSource alloc] initWithPhotos:self.photos selectedPhoto:self.photo];
    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Collection View Delegate

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//}

@end

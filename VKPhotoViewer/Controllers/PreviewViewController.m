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

@interface PreviewViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CollectionViewDataSource *collectionViewDataSource;

- (IBAction)logout:(id)sender;

@end

@implementation PreviewViewController {
    UICollectionView *previewCollectionView;
    NSArray *photoObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotoList];
}

- (void)getPhotoList {
    [APIClient getPhotoListWithSuccess:^(NSArray *photos) {
        
        photoObjects = [self getPhotoObjectArrayFromAPIArray:photos];
        [self getDataSource];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error:\n %@", error.localizedDescription);
    }];
}

- (NSMutableArray *)getPhotoObjectArrayFromAPIArray:(NSArray *)APIArray {
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

- (void)getDataSource {
    self.collectionViewDataSource = [[CollectionViewDataSource alloc] initWithPhotoArray:photoObjects];
    self.collectionView.dataSource = self.collectionViewDataSource;
}

#pragma mark - Logout

- (IBAction)logout:(id)sender {
    [LoginService logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

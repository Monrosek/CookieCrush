//
//  StoreViewController.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "StoreViewController.h"
@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _api = [[APIService alloc] initWithDelegate:self];
    [self.api downloadStoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)downloadComplete:(NSDictionary*)JsonData {
    self.store = [[StoreManager alloc] initWithDict:JsonData];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.store;
    UINib *cellNib = [UINib nibWithNibName:@"CookieCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cookie"];
    [self.collectionView reloadData];
}


@end







//
//  StoreViewController.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "StoreViewController.h"
#import "CookieCollectionViewCell.h"
#define ROUND_BUTTON_WIDTH_HEIGHT 51

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _api = [[APIService alloc] initWithDelegate:self];
    [self.api downloadStoreData];
    
    //Configure Sort button
    [[self.sortDownButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [self.sortDownButton setImage:[UIImage imageNamed:@"sortIcon"] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapCollectionView:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:doubleTapGesture];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)downloadComplete:(NSDictionary*)JsonData {
    self.store = [[StoreManager alloc] initWithDict:JsonData];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.store;
    UINib *cellNib = [UINib nibWithNibName:@"CookieCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cookie"];
    [self.collectionView reloadData];
}


- (IBAction)AscendingSort:(id)sender {
    [self.store SortCookieList];
    [self.collectionView reloadData];
}

- (void)didDoubleTapCollectionView:(UITapGestureRecognizer *)gesture {
    CGPoint pointInCollectionView = [gesture locationInView:self.collectionView];
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:pointInCollectionView];
      CookieCollectionViewCell *selectedCell = (CookieCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    NSLog(@"%@",selectedIndexPath);
    
    if([self.store isFavorite:[selectedIndexPath row]]) {
        
        selectedCell.favIcon.image = [UIImage imageNamed: @"notfav"];
    }
    else {
        
        selectedCell.favIcon.image = [UIImage imageNamed: @"fav"];
        
    }

}
@end







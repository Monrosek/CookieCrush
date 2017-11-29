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
    
    //Configure Gestures
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapCollectionView:)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self.collectionView addGestureRecognizer:singleTapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapCollectionView:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:doubleTapGesture];
    
    //Configure SearchBar
    self.searchBar.delegate = self;

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
- (void)singleTapCollectionView:(UITapGestureRecognizer *)gesture {
    [_searchBar resignFirstResponder];
}

- (void)didDoubleTapCollectionView:(UITapGestureRecognizer *)gesture {
    CGPoint pointInCollectionView = [gesture locationInView:self.collectionView];
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:pointInCollectionView];
    [self.store toggleFavorite:[selectedIndexPath row]];
    [self.collectionView reloadData];
}

#pragma mark <UISearchBarDelegate>

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length == 0) {
        [self.store endFilter];
        [self.searchBar resignFirstResponder];
        [self.collectionView reloadData];
        return;
    }
    [self.store FilterCookiesResults:searchBar.text];
    [self.collectionView reloadData];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.store endFilter];
    [self.searchBar resignFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    [self.store FilterCookiesResults:searchBar.text];
    [self.collectionView reloadData];
}

@end







//
//  StoreViewController.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"
#import "StoreManager.h"

@interface StoreViewController : UIViewController<UICollectionViewDelegate,APIDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sortDownButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) StoreManager* store;
@property (strong,nonatomic) APIService* api;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)AscendingSort:(id)sender;
- (void)didDoubleTapCollectionView:(UITapGestureRecognizer *)gesture;
- (void)singleTapCollectionView:(UITapGestureRecognizer *)gesture;

@end

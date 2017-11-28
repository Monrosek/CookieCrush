//
//  CookieCollectionViewCell.h
//  CookieCrush
//
//  Created by Mac on 11/26/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CookieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cookieView;
@property (weak, nonatomic) IBOutlet UIImageView *favIcon;
@property (nonatomic) BOOL fav;

@end

//
//  CookieCollectionViewCell.m
//  CookieCrush
//
//  Created by Mac on 11/26/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "CookieCollectionViewCell.h"

@implementation CookieCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cookieView.layer.zPosition = 5;
    self.cookieView.layer.cornerRadius = self.cookieView.frame.size.height /2;
    self.cookieView.layer.masksToBounds = YES;
}

@end

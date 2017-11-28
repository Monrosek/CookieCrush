//
//  StoreManager.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreManager : NSObject<UICollectionViewDataSource>


-(id) initWithDict: (NSDictionary*) dict;

@property (strong, nonatomic) NSMutableArray* cookies;
@property (strong, nonatomic) NSNumber* success;

@end

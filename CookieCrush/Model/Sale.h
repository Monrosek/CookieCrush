//
//  Sale.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cookie.h"

@interface Sale : NSObject

@property (strong, nonatomic) NSMutableArray* cookies;
@property (strong, nonatomic) NSNumber* success;
@end

//
//  ViewController.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreManager.h"
#import "APIService.h"
@interface ViewController : UIViewController<APIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) StoreManager* store;
@property (strong,nonatomic) APIService* api;

@end


//
//  ViewController.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "ViewController.h"
#import "StoreManager.h"
#import "Cookie.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _api = [[APIService alloc] initWithDelegate:self];
    [self.api downloadStoreData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadComplete:(NSDictionary*)JsonData {
    self.store = [[StoreManager alloc] initWithDict:JsonData];
   // self.label.text = @"hellow app";
    NSString *str = [[[self.store cookies] objectAtIndex:0] name];
    NSLog(@"%@",str);
    self.label.text = str;
}



@end

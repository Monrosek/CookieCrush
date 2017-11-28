//
//  APIService.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#define API_ROOT "https://m1xdev.coinscloud.com:49994/cookies.json"
@protocol APIDelegate<NSObject>
@required
-(void)downloadComplete:(NSDictionary*)JsonData;
@end

@interface APIService : NSObject
@property (strong, nonatomic) NSObject<APIDelegate> *delegate;
-(id) initWithDelegate: (NSObject*)delegate;
- (void) downloadStoreData;
+ (void) downloadImage: (NSString*)url
         completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

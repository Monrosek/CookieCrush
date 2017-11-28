//
//  GlobalCache.h
//  CookieCrush
//
//  Created by Mac on 11/26/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlobalCache : NSObject
-(instancetype) __unavailable init;
-(instancetype) __unavailable new;

+ (instancetype)sharedInstance;
@property (strong, nonatomic) NSCache<NSString*,UIImage*> *imageCache;
+ (UIImage*) getCachedImage:(NSString*)url;
+(void) saveImage:(UIImage*)image url:(NSString*)url;
@end

//
//  GlobalCache.m
//  CookieCrush
//
//  Created by Mac on 11/26/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "GlobalCache.h"

@implementation GlobalCache
+ (instancetype)sharedInstance {
    static GlobalCache *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        if(_imageCache == NULL) {
            _imageCache = [[NSCache alloc] init];
        }
    }
    return self;
}

+ (UIImage*) getCachedImage:(NSString*)url {
    GlobalCache *cache = [GlobalCache sharedInstance];
    UIImage *image = [cache.imageCache objectForKey:url];
    return image;
}

+(void) saveImage:(UIImage*)image url:(NSString*)url {
    GlobalCache *cache = [GlobalCache sharedInstance];
    [cache.imageCache setObject:image forKey:url];
}


@end

//
//  APIService.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "APIService.h"
#import "StoreManager.h"
#import "GlobalCache.h"
@implementation APIService

-(id) initWithDelegate: (NSObject*)delegate{
    if (self = [super init]){
        _delegate = (NSObject<APIDelegate>*)delegate;
    }
    return self;
}

- (void) downloadStoreData{
    
    NSURL *url = [NSURL URLWithString:@API_ROOT];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:url
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate downloadComplete:results];
           // NSLog(@"%@",results);
        });
    }] resume];
}

+ (void) downloadImage: (NSString*)url
     completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    UIImage *image = [GlobalCache getCachedImage:url];
    if (image != nil) {
        completionHandler(image,nil);
    }
    else {
    
    NSURL *nUrl = [NSURL URLWithString:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:nUrl
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             UIImage* image = [[UIImage alloc] initWithData:data];
                [GlobalCache saveImage:image url:url];
                completionHandler(image,error);
            
            }] resume];
    }
}


@end

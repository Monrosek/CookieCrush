//
//  Cookie.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "Cookie.h"

@implementation Cookie

-(id) initWithId: (NSNumber*)id
name: (NSString*)name
price:(NSNumber*)price
imageURL: (NSString*) imageURL
addedOn: (NSString*) addedOn {
    
    if (self = [super init]){
        _id = id;
        _name = name;
        _imageURL = imageURL;
        _price = price;
        _addedOn = addedOn;
    }
    return self;
}

@end

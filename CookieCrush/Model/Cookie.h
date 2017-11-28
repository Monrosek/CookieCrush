//
//  Cookie.h
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cookie : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *addedOn;

-(id) initWithId: (NSNumber*)id
      name: (NSString*)name
      price:(NSNumber*)price
      imageURL: (NSString*) imageURL
      addedOn: (NSString*) addedOn;
@end

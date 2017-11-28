//
//  CoreDataManager.h
//  CookieCrush
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject

+(NSManagedObjectContext*)ManagedContext;

+(void)SaveCookieToCoreData: (NSNumber*)id
        name: (NSString*)name
        price:(NSNumber*)price
        imageURL: (NSString*) imageURL
        addedOn: (NSString*) addedOn;

+(BOOL)SearchFor:(NSString*)name;
@end

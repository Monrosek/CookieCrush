//
//  CoreDataManager.m
//  CookieCrush
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "CoreDataManager.h"
#import <UIKit/UIKit.h>

@implementation CoreDataManager

+(NSManagedObjectContext*)ManagedContext {
    __block NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void)SaveCookieToCoreData: (NSNumber*)id
name: (NSString*)name
price:(NSNumber*)price
imageURL: (NSString*) imageURL
addedOn: (NSString*) addedOn {
    NSManagedObjectContext* context = [self ManagedContext];
    NSManagedObject *newCookie = [NSEntityDescription insertNewObjectForEntityForName:@"CookieEntity" inManagedObjectContext:context];
    [newCookie setValue:id forKey:@"id"];
    [newCookie setValue:name forKey:@"name"];
    [newCookie setValue:price forKey:@"price"];
    [newCookie setValue:imageURL forKey:@"imageurl"];
    [newCookie setValue:addedOn forKey:@"addedon"];
    [newCookie setValue:false forKey:@"favorite"];
    __block NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Cookie didn't save to Core Data! %@ %@", error, [error localizedDescription]);
    }
}

+(BOOL)SearchFor:(NSString*)name {
    
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cookie"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    NSMutableArray* cookies = [[context executeRequest:fetchRequest error:nil] mutableCopy];
    if ([cookies count] > 0)
        return YES;
    
    return NO;
}

@end







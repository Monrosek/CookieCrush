//
//  CoreDataManager.m
//  CookieCrush
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

#import "CoreDataManager.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation CoreDataManager

+(NSManagedObjectContext*) ManagedContext {
    return ((AppDelegate*)[[UIApplication sharedApplication]
                   delegate]).persistentContainer.viewContext;
}

+(void)SaveCookieToCoreData: (NSNumber*)id
name: (NSString*)name
price:(NSNumber*)price
imageURL: (NSString*) imageURL
addedOn: (NSString*) addedOn
favorite:(NSNumber*) favorite {
    NSManagedObjectContext* context = [self ManagedContext];
    NSManagedObject *newCookie = [NSEntityDescription insertNewObjectForEntityForName:@ENTITY inManagedObjectContext:context];
    [newCookie setValue:id forKey:@"id"];
    [newCookie setValue:name forKey:@"name"];
    [newCookie setValue:price forKey:@"price"];
    [newCookie setValue:imageURL forKey:@"imageurl"];
    [newCookie setValue:addedOn forKey:@"addedon"];
    [newCookie setValue:favorite forKey:@"favorite"];
    __block NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Cookie didn't save to Core Data! %@ %@", error, [error localizedDescription]);
    }
}

+(BOOL)SearchFor:(NSString*)name {
    
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@ENTITY];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    NSMutableArray* cookies = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if ([cookies count] > 0)
        return YES;
    return NO;
}

+(NSMutableArray*)FetchCookiesFromCoreData {
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@ENTITY];
    return [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

+(NSManagedObject*)getCookieWithName:(NSString*)name {
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@ENTITY];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    NSMutableArray* cookies = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if ([cookies count] > 0) {
        return [cookies objectAtIndex:0];
    }
    return nil;
}

+(void)RemoveCookieFromCoreData:(NSManagedObject*)cookie {
    NSManagedObjectContext *context = [self ManagedContext];
    [context deleteObject:cookie];
}

+(void)UpdateCookieAttribute:(NSString*)name fav:(NSNumber*)value{
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@ENTITY];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    NSMutableArray* cookies = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if(cookies.count > 0) {
        [[cookies objectAtIndex:0] setValue:value forKey:@"favorite"];
        __block NSError *error = nil;
        if(![context save:&error]) {
            NSLog(@"Cookie didn't update in Core Data! %@ %@", error, [error localizedDescription]);
        }
    }
    else {
        NSLog(@"%@ wasn't found in batch", name);
    }
}

+(void)RemoveAllObectsFromCoreData {
    /*
     NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Car"];
     NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
     
     NSError *deleteError = nil;
     [myPersistentStoreCoordinator executeRequest:delete withContext:myContext error:&deleteError];
     */
    
    NSManagedObjectContext *context = [self ManagedContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@ENTITY];
    NSBatchDeleteRequest *deleteAll = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
    __block NSError *deleteError = nil;
    [context executeRequest:deleteAll error:&deleteError];
}

@end






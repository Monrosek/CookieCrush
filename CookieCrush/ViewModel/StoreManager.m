//
//  StoreManager.m
//  CookieCrush
//
//  Created by Mac on 11/25/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.


#import "StoreManager.h"
#import "Cookie.h"
#import "CookieCollectionViewCell.h"
#import "APIService.h"
#import "CoreDataManager.h"

@implementation StoreManager
static NSString * const reuseIdentifier = @"cookie";

-(id) initWithDict: (NSDictionary*) dict {

    if (self = [super init]){
        
        _success = [dict objectForKey:@"success"];
        NSArray *cookieBatch = [dict objectForKey:@"cookies"];
        //_cookies = [NSMutableArray new];
        for (NSDictionary *dic in cookieBatch) {
            NSNumber* id = (NSNumber*)[dic objectForKey:@"id"];
            NSString *name = (NSString*)[dic objectForKey:@"name"];
            NSNumber *price = (NSNumber*)[dic objectForKey:@"price"];
            NSString *imageURL = (NSString*)[dic objectForKey:@"imageURL"];
            NSString *addedOn = (NSString*)[dic objectForKey:@"addedOn"];
            
            if([CoreDataManager SearchFor:name] == NO) {
                [CoreDataManager SaveCookieToCoreData:id name:name price:price imageURL:imageURL addedOn:addedOn favorite:[NSNumber numberWithInt:0]];
            }
            else {
                NSLog(@"%@ cookie already in batch", name);
            }
        }
        
       // [CoreDataManager RemoveAllObectsFromCoreData];
        self.cookies = [CoreDataManager FetchCookiesFromCoreData];
        self.isFiltered = false;
    }
    return self;
}


-(void)SortCookieList {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _cookies = (NSMutableArray*)[_cookies sortedArrayUsingDescriptors:sortDescriptors];
//    if(_isFiltered == YES) {
//        _filteredCookies = (NSMutableArray*)[_filteredCookies sortedArrayUsingDescriptors:sortDescriptors];
//    }
    // NSLog(@"%@", self.cookies);
}

-(BOOL)isFavorite:(NSInteger)index {
    NSManagedObject *cookie = [self.cookies objectAtIndex:index];
    NSLog(@"%@'s Favorite: %@",[cookie valueForKey:@"name"],[cookie valueForKey:@"favorite"]);
    if([cookie valueForKey:@"favorite"] > 0) {
        return YES;
    }
    return NO;
}

-(void)toggleFavorite:(NSInteger)index {
    
    __block  NSString* name = nil;
    __block  NSNumber* fav = nil;
    
    if(_isFiltered == YES) {
        name = [[_filteredCookies objectAtIndex:index] name];
        fav = [[_filteredCookies objectAtIndex:index] valueForKey:@"favorite"];
        if ([fav intValue] == 0)
            fav = [NSNumber numberWithInt:1];
        else {
            fav = [NSNumber numberWithInt:0];
        }
        [[_filteredCookies objectAtIndex:index] setValue:fav forKey:@"favorite"];
        
        for(NSManagedObject* cookie in _cookies) {
            if([[cookie valueForKey:@"name"] isEqualToString:name]) {
                [cookie setValue:fav forKey:@"favorite"];
            }
        }
    }
    else {
        name = [[_cookies objectAtIndex:index] name];
        fav = [[_cookies objectAtIndex:index] valueForKey:@"favorite"];
        if ([fav intValue] == 0)
            fav = [NSNumber numberWithInt:1];
        else {
            fav = [NSNumber numberWithInt:0];
        }
        [[_cookies objectAtIndex:index] setValue:fav forKey:@"favorite"];
    }

    [CoreDataManager UpdateCookieAttribute:name fav:fav];
    NSLog(@"%@'s favorite set to %@",name, fav);
    //_cookies = [CoreDataManager FetchCookiesFromCoreData];
}

-(void)FilterCookiesResults:(NSString*)searchText {
    self.isFiltered = true;
    __block NSMutableArray* filteredResults = [[NSMutableArray alloc] init];
    for (NSManagedObject* cookie in _cookies)
    {
        NSString* name = [cookie valueForKey:@"name"];
        NSRange nameRange = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(nameRange.location != NSNotFound)
        {
            [filteredResults addObject:cookie];
        }
    }
    _filteredCookies = filteredResults;
}

-(void)endFilter {
    _isFiltered = false;
    [_filteredCookies removeAllObjects];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_isFiltered == true) {
        return _filteredCookies.count;
    }
    else {
        return [_cookies count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CookieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    __block NSManagedObject *cookie = nil;
    if(_isFiltered == true) {
       cookie = [self.filteredCookies objectAtIndex:[indexPath row]];
    }
    else {
        cookie = [self.cookies objectAtIndex:[indexPath row]];
    }
    
    cell.nameLabel.text = [cookie valueForKey:@"name"];
   // double price = [[[cookie valueForKey:@"price"] doubleValue] string];
    cell.priceLabel.text = [[NSNumber numberWithDouble:[[cookie valueForKey:@"price"] doubleValue]]stringValue];
    NSString *imgURL = [cookie valueForKey:@"imageurl"];
    [APIService downloadImage:imgURL
            completionHandler:^(UIImage *image, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if( image != NULL) {cell.cookieView.image = image;}
                    else { NSLog(@"%@",error);}});}];
    if([cookie valueForKey:@"favorite"] == [NSNumber numberWithInt:1]) {
        cell.favIcon.image = [UIImage imageNamed: @"fav"];
    }
    else {
        cell.favIcon.image = [UIImage imageNamed: @"notFav"];
    }
    NSLog(@"Favorite is: %@",[cookie valueForKey:@"favorite"]);
    return cell;
}




@end















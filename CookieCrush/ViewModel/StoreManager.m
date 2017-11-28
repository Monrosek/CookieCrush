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
                [CoreDataManager SaveCookieToCoreData:id name:name price:price imageURL:imageURL addedOn:addedOn favorite:0];
            }
        }
        
        self.cookies = [CoreDataManager FetchCookiesFromCoreData];
        
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_cookies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CookieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSManagedObject *cookie = [self.cookies objectAtIndex:[indexPath row]];
    cell.nameLabel.text = [cookie valueForKey:@"name"];
    cell.priceLabel.text = [[cookie valueForKey:@"price"] stringValue];
    NSString *imgURL = [cookie valueForKey:@"imageurl"];
    [APIService downloadImage:imgURL
            completionHandler:^(UIImage *image, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if( image != NULL) {cell.cookieView.image = image;}
                    else { NSLog(@"%@",error);}});}];
    return cell;
}

-(void)SortCookieList {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _cookies = (NSMutableArray*)[_cookies sortedArrayUsingDescriptors:sortDescriptors];
   // NSLog(@"%@", self.cookies);
}

-(BOOL)isFavorite:(NSInteger)index {
    NSManagedObject *cookie = [self.cookies objectAtIndex:index];
    if([cookie valueForKey:@"favorite"] > 0) {
        return YES;
    }
    return NO;
}

-(void)addToFavorites:(NSInteger)index {
  //  NSManagedObject *cookie = [self.cookies objectAtIndex:index];
    
}

@end















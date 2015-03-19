//
//  AggregateDataStore.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/18/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "AggregateDataStore.h"
#import "GoogleAPIClient.h"
#import "YelpAPIClient.h"
#import "FourSquareAPIClient.h"

@implementation AggregateDataStore

- (void)getGoogleDataWithTerm:(NSString *)term
                     Latitude:(NSString *)latitude
                    Longitude:(NSString *)longitude
            CompletionHandler:(void (^)(NSArray *googleArray))completionBlock {
    
    GoogleAPIClient *client = [[GoogleAPIClient alloc] init];
    
    [client getNamesOfAllGooglePlacesWithTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *venueNames) {
        completionBlock(venueNames);
    }];
    
}

- (void)getYelpDataWithTerm:(NSString *)term
                   Latitude:(NSString *)latitude
                  Longitude:(NSString *)longitude
          CompletionHandler:(void (^)(NSArray *yelpArray))completionBlock {
    
    YelpAPIClient *client = [[YelpAPIClient alloc] init];
    
    [client queryTopBusinessInfoForTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *yelpVenues) {
        completionBlock(yelpVenues);
    }];
    
}

- (void)getFourSquareDataWithTerm:(NSString *)term
                        Latitiude:(NSString *)latitude
                        Longitude:(NSString *)longitude
                CompletionHandler:(void (^)(NSArray *fourSquareArray))completionBlock {
    
    FourSquareAPIClient *client = [[FourSquareAPIClient alloc] init];
    
    [client getNamesOfAllFoursquareVenuesWithTerm:term Latitiude:latitude Longitude:longitude CompletionHandler:^(NSArray *venueNames) {
        completionBlock(venueNames);
        
    }];
    
}

+ (instancetype)sharedDataStore {
    static AggregateDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[AggregateDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

@end

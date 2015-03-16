//
//  FourSquareDataStore.m
//  technical-presentation-flatiron
//
//  Created by Nicolas Rizk on 3/12/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "FourSquareDataStore.h"
#import "FourSquareAPIClient.h"

@implementation FourSquareDataStore

- (void)getFourSquareDataWithCompletionHandler:(void (^)(NSArray *fourSquareArray))completionBlock {
    
    FourSquareAPIClient *client = [[FourSquareAPIClient alloc] init];
    
    [client getNamesOfAllFoursquareVenuesNearZipCode:@10004 CompletionHandler:^(NSArray *venueNames) {
        
        completionBlock(venueNames);
        NSLog(@"The Foursquare Venues are: %@",venueNames);
        
    }];
}

+ (instancetype)sharedDataStore {
    static FourSquareDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FourSquareDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

@end

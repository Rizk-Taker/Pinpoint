//
//  PinpointDataStore.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "PinpointDataStore.h"
#import "YelpDataStore.h"
#import "FourSquareDataStore.h"

@implementation PinpointDataStore

+ (instancetype)sharedDataStore {
    static PinpointDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[PinpointDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (void) combineYelpandFoursquareResultsWithTerm:(NSString *)term Location:(NSString *)location CompletionHandler:(void (^)(NSArray *pinPointArray))completionBlock {
    
    
    self.yelpDataStore = [YelpDataStore sharedDataStore];
    
    [self.yelpDataStore getYelpDataWithTerm:term Location:location CompletionHandler:^(NSArray *yelpArray) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"We are accessing Yelp's data store through Pinpoint Data Store");
        }];
    }];
    
    self.fourSquareDataStore = [FourSquareDataStore sharedDataStore];
    
    [self.fourSquareDataStore getFourSquareDataWithCompletionHandler:^void(NSArray *fourSquareArray) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"We are accessing Foursquare's data store through Pinpoint Data Store");
        }];
    }];
}

@end

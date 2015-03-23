//
//  PinpointComparisonHelper.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/18/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "PinpointComparisonHelper.h"
#import "AggregateDataStore.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"
#import "GoogleAPIClient.h"

@implementation PinpointComparisonHelper

// YELP PATH TO LAT N LONGS
// searchRepoJSON[@"businesses"][0][@"location"][@"coordinate"][@"latitude"]

- (void) combineResultsWithTerm:(NSString *)term
                      Latitiude:(NSString *)latitude
                      Longitude:(NSString *)longitude
              CompletionHandler:(void (^)(NSArray *pinPointArray))completionBlock {
    
    self.googleProxy = [GoogleAPIClient sharedProxy];
    self.foursquareProxy = [FourSquareAPIClient sharedProxy];
    self.yelpProxy = [YelpAPIClient sharedProxy];
    
    __block NSArray *yelpData = [[NSArray alloc] init];
    __block NSArray *googleData = [[NSArray alloc] init];
    __block NSArray *foursquareData = [[NSArray alloc] init];
    
//    NSArray *results = [[NSArray alloc] init];
    
    self.dataStore = [AggregateDataStore sharedDataStore];
    [self.dataStore getYelpDataWithTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *yelpArray) {
        yelpData = yelpArray;
        NSLog(@"I am in Yelp's Data Store");
    }];
    
    
    [self.dataStore getFourSquareDataWithTerm:term Latitiude:latitude Longitude:longitude CompletionHandler:^(NSArray *fourSquareArray) {
        foursquareData = fourSquareArray;
        NSLog(@"I am in Foursquare's data store");
    }];
    
    
    [self.dataStore getGoogleDataWithTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *googleArray) {
        googleData = googleArray;
        NSLog(@"I am in Google Place's data store");
    }];
   
    completionBlock(googleData);
    
    
    
    
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //        }];
    
    
}

@end

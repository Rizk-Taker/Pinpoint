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
#import "GooglePlace.h"
#import "Yelpers.h"
#import "FourSquares.h"
#import "Pinpoint.h"

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
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    self.dataStore = [AggregateDataStore sharedDataStore];
    
    [self.dataStore getGoogleDataWithTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *googleArray) {
        
        [self.dataStore getFourSquareDataWithTerm:term Latitiude:latitude Longitude:longitude CompletionHandler:^(NSArray *fourSquareArray) {
            
            [self.dataStore getYelpDataWithTerm:term Latitude:latitude Longitude:longitude CompletionHandler:^(NSArray *yelpArray) {
                
                yelpData = yelpArray;
                NSLog(@"I am in Yelp's Data Store");
                
                foursquareData = fourSquareArray;
                NSLog(@"I am in Foursquare's data store");
                
                googleData = googleArray;
                NSLog(@"I am in Google Place's data store");
                
                NSMutableDictionary *pinPointsDictionary = [[NSMutableDictionary alloc] init];
                
                
                for (GooglePlace *googlePlace in googleData) {
                    Pinpoint *pinpoint = [[Pinpoint alloc] init];
                    pinpoint.name = googlePlace.name;
                    pinpoint.openNow = googlePlace.openNow;
                    pinpoint.googleRating = googlePlace.rating;
                    pinpoint.googlePriceLevel = googlePlace.priceLevel;
                    
                    pinPointsDictionary[pinpoint.name] = [[NSMutableDictionary alloc] initWithDictionary:@{ @"quantity": @1,@"pinpoint": pinpoint}];
                }
                
                for (FourSquares *fourSquarePlace in foursquareData) {
                    
                    if (pinPointsDictionary[fourSquarePlace.name]) {
                        NSInteger quantity = [pinPointsDictionary[fourSquarePlace.name][@"quantity"] integerValue];
                        
                        quantity += 1;
                        
                        pinPointsDictionary[fourSquarePlace.name][@"quantity"] = @(quantity);
                        
                        Pinpoint *pinpoint = pinPointsDictionary[fourSquarePlace.name][@"pinpoint"];
                        
                        pinpoint.foursquareRating = fourSquarePlace.rating;
                        pinpoint.fourSquarePriceLevel = fourSquarePlace.priceLevel;
                        pinpoint.address = fourSquarePlace.address;
                        pinpoint.url = [NSURL URLWithString:fourSquarePlace.url];
                        pinpoint.zipCode = fourSquarePlace.zipCode;
                        pinpoint.state = fourSquarePlace.state;
                        pinpoint.city = fourSquarePlace.city;
                        pinpoint.phoneNumber = fourSquarePlace.phoneNumber;
                    }
                }
                
                for (Yelpers *yelpPlace in yelpData) {
                    
                    if (pinPointsDictionary[yelpPlace.name]) {
                        NSInteger quantity = [pinPointsDictionary[yelpPlace.name][@"quantity"] integerValue];
                        
                        quantity += 1;
                        
                        pinPointsDictionary[yelpPlace.name][@"quantity"] = @(quantity);
                        
                        Pinpoint *pinpoint = pinPointsDictionary[yelpPlace.name][@"pinpoint"];
                        
                        pinpoint.yelpRating = yelpPlace.rating;
                        pinpoint.image = yelpPlace.image;
                    }
                }
                
                
                for (NSString *key in pinPointsDictionary) {
                    if ([pinPointsDictionary[key][@"quantity"] isEqual:@3]) {
                        [results addObject:pinPointsDictionary[key][@"pinpoint"]];
                    }
                }
                
                completionBlock(results);
            }];
        }];
    }];
    
    
    
    
    
}

@end

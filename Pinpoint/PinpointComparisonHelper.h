//
//  PinpointComparisonHelper.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/18/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FourSquareAPIClient;
@class YelpAPIClient;
@class GoogleAPIClient;
@class AggregateDataStore;

@interface PinpointComparisonHelper : NSObject
- (void) combineResultsWithTerm:(NSString *)term
                      Latitiude:(NSString *)latitude
                      Longitude:(NSString *)longitude
              CompletionHandler:(void (^)(NSArray *pinPointArray))completionBlock;

@property (strong, nonatomic) AggregateDataStore  *dataStore;
@property (strong, nonatomic) GoogleAPIClient *googleProxy;
@property (strong, nonatomic) FourSquareAPIClient *foursquareProxy;
@property (strong, nonatomic) YelpAPIClient *yelpProxy;
@end

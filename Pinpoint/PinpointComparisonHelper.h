//
//  PinpointComparisonHelper.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/18/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AggregateDataStore;

@interface PinpointComparisonHelper : NSObject
- (void) combineResultsWithTerm:(NSString *)term
                      Latitiude:(NSString *)latitude
                      Longitude:(NSString *)longitude
              CompletionHandler:(void (^)(NSArray *pinPointArray))completionBlock;

@property (strong, nonatomic) AggregateDataStore  *dataStore;

@end

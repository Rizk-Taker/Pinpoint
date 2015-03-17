//
//  PinpointDataStore.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FourSquareDataStore;
@class YelpDataStore;

@interface PinpointDataStore : NSObject

- (void) combineYelpandFoursquareResultsWithTerm:(NSString *)term Location:(NSString *)location CompletionHandler:(void (^)(NSArray *pinPointArray))completionBlock;

@property (strong, nonatomic) FourSquareDataStore *fourSquareDataStore;
@property (strong, nonatomic) YelpDataStore *yelpDataStore;

+ (instancetype)sharedDataStore;
@end

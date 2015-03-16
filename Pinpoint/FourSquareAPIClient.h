//
//  FourSquareAPIClient.h
//  technical-presentation-flatiron
//
//  Created by Nicolas Rizk on 3/12/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquareAPIClient : NSObject

-(void)getNamesOfAllFoursquareVenuesNearZipCode:(NSNumber *)zipCode
                              CompletionHandler:(void (^)(NSArray *venueNames))completionBlock;


@end

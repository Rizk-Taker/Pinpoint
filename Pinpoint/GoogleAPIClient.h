//
//  GoogleAPIClient.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GoogleAPIClient : NSObject

- (void)getNamesOfAllGooglePlacesWithTerm: (NSString *)term
                                Latitude:(NSString *)latitude
                               Longitude:(NSString *)longitude
                       CompletionHandler:(void (^)(NSArray *venueNames))completionBlock;

+ (GoogleAPIClient *)sharedProxy;

@end

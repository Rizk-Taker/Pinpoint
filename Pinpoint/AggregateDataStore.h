//
//  AggregateDataStore.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/18/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AggregateDataStore : NSObject

- (void)getGoogleDataWithTerm:(NSString *)term
                     Latitude:(NSString *)latitude
                    Longitude:(NSString *)longitude
            CompletionHandler:(void (^)(NSArray *googleArray))completionBlock;


- (void)getYelpDataWithTerm:(NSString *)term
                   Latitude:(NSString *)latitude
                  Longitude:(NSString *)longitude
          CompletionHandler:(void (^)(NSArray *yelpArray))completionBlock;

- (void)getFourSquareDataWithTerm:(NSString *)term
                        Latitiude:(NSString *)latitude
                        Longitude:(NSString *)longitude
                CompletionHandler:(void (^)(NSArray *fourSquareArray))completionBlock;

+ (instancetype)sharedDataStore;



@end

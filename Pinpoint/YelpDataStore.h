//
//  YelpDataStore.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/16/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpDataStore : NSObject

- (void)getYelpDataWithTerm:(NSString *)term Location:(NSString *)location CompletionHandler:(void (^)(NSArray *yelpArray))completionBlock;
+ (instancetype)sharedDataStore;

@end
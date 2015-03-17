//
//  YelpDataStore.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/16/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "YelpDataStore.h"
#import "YPAPISample.h"

@implementation YelpDataStore

- (void)getYelpDataWithTerm:(NSString *)term Location:(NSString *)location CompletionHandler:(void (^)(NSArray *yelpArray))completionBlock {
    
    YPAPISample *client = [[YPAPISample alloc] init];
    
    [client queryTopBusinessInfoForTerm:term location:location completionHandler:^(NSArray *venueNames) {
        NSLog(@"I am in Yelp's Data Store");
    }];
 
}


+ (instancetype)sharedDataStore {
    static YelpDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[YelpDataStore alloc] init];
    });
    
    return _sharedDataStore;
}
                                                                            
@end

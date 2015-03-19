//
//  GoogleAPIClient.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "GoogleAPIClient.h"
#import "GooglePlaces.h"
#import <AFNetworking.h>
#import "SPGooglePlacesAutocomplete.h"
#import "SPGooglePlacesPlaceDetailQuery.h"

#define GOOGLE_API_KEY @"AIzaSyA7-FMzdLbN48sM_qZ3GBs85qvptW4ge5Q"
@interface GoogleAPIClient ()

@property (strong, nonatomic) SPGooglePlacesAutocompleteQuery *searchQuery;

@end

@implementation GoogleAPIClient

+ (instancetype)sharedProxy
{
    static GoogleAPIClient *sharedProxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
}

- (instancetype)init
{
    static NSString * const kGooglePlacesAPIKey = @"AIzaSyA7-FMzdLbN48sM_qZ3GBs85qvptW4ge5Q&location";
    
    if (self = [super init]) {
        self.searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:kGooglePlacesAPIKey];
    }
    return self;
}


- (void)getNamesOfAllGooglePlacesWithTerm: (NSString *)term
                                Latitude:(NSString *)latitude
                               Longitude:(NSString *)longitude
                       CompletionHandler:(void (^)(NSArray *venueNames))completionBlock
{
    NSString *googleStringURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"];
    
    NSString *latlng = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    
    NSDictionary *urlParams = @{@"key":GOOGLE_API_KEY, @"location": latlng, @"keyword":term, @"radius":@"20000"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:googleStringURL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *venuesArray = responseObject[@"results"];
        NSMutableArray *googleVenues = [[NSMutableArray alloc] init];
        for (NSDictionary *venue in venuesArray) {
            GooglePlaces *googleVenue = [[GooglePlaces alloc] initWithName:venue[@"name"] Latitude:venue[@"geometry"][@"location"][@"lat"] Longitude:venue[@"geometry"][@"location"][@"lng"] Address:venue[@"vicinity"] Rating:venue[@"rating"] PriceLevel:venue[@"price_level"] OpenNow:venue[@"opening_hours"][@"open_now"]];
            [googleVenues addObject:googleVenue];
        }
        
        completionBlock(googleVenues);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Could not get google data");
    }];

}
@end

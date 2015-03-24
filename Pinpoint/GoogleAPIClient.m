//
//  GoogleAPIClient.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "GoogleAPIClient.h"
#import "GooglePlace.h"
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


- (void)handleSearchForSearchString:(NSString *)searchString withCompletionBlock:(void (^)(BOOL success, NSArray *places))completionBlock
{
    self.searchQuery.input = searchString;
    [self.searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not fetch Places" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                completionBlock(NO, nil);
             } else {
                // FIXME: this is a very brittle way to implement current location
                NSMutableArray *placesWithCurrentLocation = [NSMutableArray arrayWithObject:@"Current Location"];
                [placesWithCurrentLocation addObjectsFromArray:places];
                completionBlock(YES, placesWithCurrentLocation);
            }
        }];
    }];
}

- (void)getNamesOfAllGooglePlacesWithTerm: (NSString *)term
                                Latitude:(NSString *)latitude
                               Longitude:(NSString *)longitude
                       CompletionHandler:(void (^)(NSArray *venueNames))completionBlock
{
    NSString *googleSearchStringURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"];
    
    NSString *latlng = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    
    NSDictionary *urlParams = @{@"key":GOOGLE_API_KEY, @"location": latlng, @"keyword":term, @"radius":@"50000"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:googleSearchStringURL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *venuesArray = responseObject[@"results"];
        NSMutableArray *googleVenues = [[NSMutableArray alloc] init];
        for (NSDictionary *venue in venuesArray) {
            
            NSString *latString = [NSString stringWithFormat:@"%@", venue[@"geometry"][@"location"][@"lat"]];
            if ([latString length] >= 6) {
//            if ([latString hasPrefix:@"-"]) {
//             latString = [latString substringToIndex:7];
//            } else {
            latString = [latString substringToIndex:7];
//            }
            } else {
                NSLog(@"Google Lat too short");
            }
            
            NSString *lngString = [NSString stringWithFormat:@"%@", venue[@"geometry"][@"location"][@"lng"]];
            if ([lngString length] >= 6) {
//            if ([lngString hasPrefix:@"-"]) {
//                lngString = [latString substringToIndex:7];
//            } else {
                lngString = [lngString substringToIndex:7];
//            }
            } else {
                NSLog(@"Google Long too short");
            }
            NSString *venueVicinity = venue[@"vicinity"];
            NSString *venueString = [venueVicinity componentsSeparatedByString:@","][0];
            
           

            GooglePlace *googleVenue = [[GooglePlace alloc] initWithName:venue[@"name"] Latitude:latString Longitude:lngString Address:venueString Rating:[NSString stringWithFormat:@"%@", venue[@"rating"]] PriceLevel:[NSString stringWithFormat:@"%@", venue[@"price_level"]] OpenNow:[NSString stringWithFormat:@"%@", venue[@"opening_hours"][@"open_now"]]];
            [googleVenues addObject:googleVenue];
        }
        
        completionBlock(googleVenues);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Could not get google data");
    }];

}
@end

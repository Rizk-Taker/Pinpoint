//
//  FourSquareAPIClient.m
//  technical-presentation-flatiron
//
//  Created by Nicolas Rizk on 3/12/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//



#import "FourSquareAPIClient.h"
#import "FourSquares.h"
#import <AFNetworking.h>

#define ClIENT_ID @"NGM1D44QJ2XO24YTY52BJ4UXI4ZYABMCNK5LDOXGFBU4X20P"
#define CLIENT_SECRET @"5W5EIH2FLYR35SFW3R3EFPZPACWJDL0EXM2KX1GW12XVMNSG"
#define V @"20140806"

@implementation FourSquareAPIClient

+ (instancetype)sharedProxy
{
    static FourSquareAPIClient *sharedProxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
}

-(void)getNamesOfAllFoursquareVenuesWithTerm: (NSString *)term
                                   Latitiude:(NSString *)latitude
                                   Longitude:(NSString *)longitude
                           CompletionHandler:(void (^)(NSArray *venueNames))completionBlock
{

    NSString *foursquareStringURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *latlng = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    
    NSDictionary *urlParams = @{@"client_id": ClIENT_ID, @"client_secret": CLIENT_SECRET, @"v":V, @"ll": latlng, @"query":term};
    
    [manager GET:foursquareStringURL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Got Foursquare Data");
        
        NSArray *venuesArray = responseObject[@"response"][@"groups"][0][@"items"];
        
        NSMutableArray *foursquareVenues = [[NSMutableArray alloc] init];
    
        for (NSDictionary *venue in venuesArray) {
            
            NSString *latString = [NSString stringWithFormat:@"%@", venue[@"venue"][@"location"][@"lat"]];
            
            if ([latString length] >= 6) {
//            if ([latString hasPrefix:@"-"]) {
//                latString = [latString substringToIndex:7];
//            } else {
                latString = [latString substringToIndex:6];
//            }
            } else {
                NSLog(@"Foursquare Lat too short");
            }

            NSString *lngString = [NSString stringWithFormat:@"%@", venue[@"venue"][@"location"][@"lng"]];
            
             if ([lngString length] >= 6) {
//            if ([lngString hasPrefix:@"-"]) {
//                lngString = [latString substringToIndex:7];
//            } else {
                lngString = [latString substringToIndex:6];
//            }
             } else {
                 NSLog(@"Foursquare Long too short");
             }
            FourSquares *foursquareVenue = [[FourSquares alloc] initWithName:venue[@"venue"][@"name"] Latitude:latString Longitude:lngString Address:venue[@"venue"][@"location"][@"address"]                        State:venue[@"venue"][@"location"][@"state"]  City:venue[@"venue"][@"location"][@"city"] Rating:venue[@"venue"][@"rating"] Url:venue[@"venue"][@"url"] Zipcode:venue[@"venue"][@"location"][@"postalCode"] PhoneNumber:venue[@"venue"][@"contact"][@"formattedPhone"] PriceLevel:venue[@"venue"][@"price"][@"tier"]];
            [foursquareVenues addObject:foursquareVenue];
        }
        
        completionBlock(foursquareVenues);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


@end


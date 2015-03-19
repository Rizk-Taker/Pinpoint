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
            FourSquares *foursquareVenue = [[FourSquares alloc] initWithName:venue[@"venue"][@"name"] Latitude:venue[@"venue"][@"location"][@"lat"] Longitude:venue[@"venue"][@"location"][@"lng"] Address:venue[@"venue"][@"location"][@"address"] Rating:venue[@"venue"][@"rating"] Url:venue[@"venue"][@"url"] Zipcode:venue[@"venue"][@"location"][@"postalCode"] PhoneNumber:venue[@"venue"][@"contact"][@"formattedPhone"]];
            [foursquareVenues addObject:foursquareVenue];
        }
        
        completionBlock(foursquareVenues);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


@end


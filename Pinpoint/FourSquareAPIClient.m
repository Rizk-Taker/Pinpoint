//
//  FourSquareAPIClient.m
//  technical-presentation-flatiron
//
//  Created by Nicolas Rizk on 3/12/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "FourSquareAPIClient.h"

@implementation FourSquareAPIClient

-(void)getNamesOfAllFoursquareVenuesNearZipCode:(NSNumber *)zipCode
                              CompletionHandler:(void (^)(NSArray *venuNames))completionBlock
{
    NSURLSession *mySession = [NSURLSession sharedSession];
    NSString *baseURL = @"https://api.foursquare.com/v2/";
    NSString *baseParams = @"client_id=NGM1D44QJ2XO24YTY52BJ4UXI4ZYABMCNK5LDOXGFBU4X20P&client_secret=5W5EIH2FLYR35SFW3R3EFPZPACWJDL0EXM2KX1GW12XVMNSG&v=20140806";
    
    NSString *searchString = [NSString stringWithFormat:@"%@venues/search?%@&near=%@",baseURL,baseParams,zipCode];
    NSURL *foursquareURL = [NSURL URLWithString:searchString];
    
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:foursquareURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0 error:nil];
        
        NSArray *venuesArray = resultDictionary[@"response"][@"venues"];
        NSMutableArray *venueNames = [[NSMutableArray alloc] init];
        for (NSDictionary *venue in venuesArray) {
            [venueNames addObject:venue[@"name"]];
        }
        
        completionBlock(venueNames);
        
    }];
    
    [task resume];
}



@end


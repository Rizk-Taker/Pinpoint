//
//  YPAPISample.m
//  YelpAPI

#import "YelpAPIClient.h"
#import "NSURLRequest+OAuth.h"
#import "Yelpers.h"


/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"20";

@implementation YelpAPIClient

#pragma mark - Public

+ (instancetype)sharedProxy
{
    static YelpAPIClient *sharedProxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
}

//- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location
//                  completionHandler:(void (^)(NSArray *yelpVenues))completionHandler {
//    
//    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
//    
//    //Make a first request to get the search results with the passed term and location
//    NSURLRequest *searchRequest = [self _searchRequestWithTerm:@"chinese" location:@"manhattan"];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        
//        if (!error && httpResponse.statusCode == 200) {
//            
//            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSArray *businessArray = searchResponseJSON[@"businesses"];
//            
//            NSMutableArray *yelpVenues = [[NSMutableArray alloc] init];
//            for (NSDictionary *venue in businessArray) {
//                Yelpers *yelpLocation = [[Yelpers alloc] initWithName:venue[@"name"] Latitude:venue[@"location"][@"coordinate"][@"latitude"] Longitude:venue[@"location"][@"coordinate"][@"longitude"] Address:venue[@"location"][@"display_address"] Rating:venue[@"rating"] Url:venue[@"url"] Zipcode:venue[@"location"][@"postal_code"] PhoneNumber:venue[@"display_phone"]];
//
//                [yelpVenues addObject:yelpLocation];
//            }
//            
//            completionHandler(yelpVenues);
//            //      if ([businessArray count] > 0) {
//            //        NSDictionary *firstBusiness = [businessArray firstObject];
//            //        NSString *firstBusinessID = firstBusiness[@"id"];
//            //        NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
//            //
//            //        [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
//            //      } else {
//            //        completionHandler(nil, error); // No business was found
//            //      }
//        }
//        else {
//            NSLog(@"Probably a STATUS CODE error");
//        }
//    }] resume];
//}
- (void)queryTopBusinessInfoForTerm:(NSString *)term Latitude:(NSString *)latitude Longitude:(NSString *)longitude CompletionHandler:(void (^)(NSArray *yelpVenues))completionHandler {
    
    NSLog(@"Querying the Search API with term \'%@\' and latitude \'%@' and longitude \'%@' ", term, latitude,longitude);
    
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term Latitude:latitude Longitude:longitude];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            NSMutableArray *yelpVenues = [[NSMutableArray alloc] init];
            for (NSDictionary *venue in businessArray) {
                Yelpers *yelpLocation = [[Yelpers alloc] initWithName:venue[@"name"] Latitude:venue[@"location"][@"coordinate"][@"latitude"] Longitude:venue[@"location"][@"coordinate"][@"longitude"] Address:venue[@"location"][@"display_address"] Rating:venue[@"rating"] Url:venue[@"url"] Zipcode:venue[@"location"][@"postal_code"] PhoneNumber:venue[@"display_phone"]];
                
                [yelpVenues addObject:yelpLocation];
            }
            
            completionHandler(yelpVenues);
            //      if ([businessArray count] > 0) {
            //        NSDictionary *firstBusiness = [businessArray firstObject];
            //        NSString *firstBusinessID = firstBusiness[@"id"];
            //        NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
            //
            //        [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
            //      } else {
            //        completionHandler(nil, error); // No business was found
            //      }
        }
        else {
            NSLog(@"YELP STATUS CODE ERROR");
        }
    }] resume];
}

//- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
//    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if (!error && httpResponse.statusCode == 200) {
//            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            
//            completionHandler(businessResponseJSON, error);
//        } else {
//            completionHandler(nil, error);
//        }
//    }] resume];
//    
//}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term Latitude:(NSString *)latitude Longitude:(NSString *)longitude {
    
    NSString *latAndLngs = [NSString stringWithFormat:@"%@,%@",latitude,longitude];

    NSDictionary *params = @{@"term": term, @"ll": latAndLngs, @"limit": kSearchLimit};
    
    NSLog(@"%@",[NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params]);
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}

@end

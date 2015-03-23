//
//  Pinpoint.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/23/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "Pinpoint.h"

@implementation Pinpoint

- (instancetype)initWithName:(NSString *)name // use foursquare or google
                    Address:(NSString *)address // use foursquare
                        Url:(NSURL *)url // use foursquare
                       State:(NSString *)state // use foursquare
                        City:(NSString *)city // use foursquare
                    Zipcode:(NSString *)zipCode // use foursquare CONVERT
                PhoneNumber:(NSString *)phoneNumber // use foursquare
               GoogleRating:(NSString *)googleRating
           FoursquareRating:(NSString *)fourSquareRating
                 YelpRating:(NSString *)yelpRating
           GooglePriceLevel:(NSString *)googlePriceLevel
       FoursquarePriceLevel:(NSString *)fourSquarePriceLevel
                    OpenNow:(NSString *)openNow // use Google
                       Image:(UIImage *)image // use Yelp
//add state and city
{
    self = [super init];
    
    if (self) {
        _name = name;
        _address = address;
        _url = url;
        _zipCode = zipCode;
        _phoneNumber = phoneNumber;
        _googleRating = googleRating;
        _foursquareRating = fourSquareRating;
        _yelpRating = yelpRating;
        _googlePriceLevel = googlePriceLevel;
        _fourSquarePriceLevel = fourSquarePriceLevel;
        _openNow = openNow;
        _image = image;
    }
    return self;
}
@end

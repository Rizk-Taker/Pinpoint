//
//  Pinpoint.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/23/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "Pinpoint.h"

@implementation Pinpoint

- (instancetype)initWithName:(NSString *)name
                    Address:(NSString *)address
                        Url:(NSURL *)url
                       State:(NSString *)state
                        City:(NSString *)city
                    Zipcode:(NSString *)zipCode
                PhoneNumber:(NSString *)phoneNumber
               GoogleRating:(NSString *)googleRating
           FoursquareRating:(NSString *)fourSquareRating
                 YelpRating:(NSString *)yelpRating
           GooglePriceLevel:(NSString *)googlePriceLevel
       FoursquarePriceLevel:(NSString *)fourSquarePriceLevel
                    OpenNow:(NSString *)openNow
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

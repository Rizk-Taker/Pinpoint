//
//  GooglePlaces.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace
- (instancetype)initWithName:(NSString *)name
                    Latitude:(NSString *)latitude
                   Longitude:(NSString *)longitude
                     Address:(NSString *)address
                      Rating:(NSString *)rating
                  PriceLevel:(NSString *)priceLevel
                     OpenNow:(NSString *)openNow
 {
    self = [super init];
    
    if (self) {
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
        _address = address;
        _rating = rating;
        _priceLevel = priceLevel;
        _openNow = openNow;

    }
    return self;
}
@end

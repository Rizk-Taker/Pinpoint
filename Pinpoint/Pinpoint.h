//
//  Pinpoint.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/23/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Pinpoint : NSObject

@property (strong, nonatomic) NSString *name;

//@property (strong, nonatomic) NSString *latitude;
//@property (strong, nonatomic) NSString *longitude;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *phoneNumber;

@property (strong, nonatomic) NSString *googleRating;
@property (strong, nonatomic) NSString *foursquareRating;
@property (strong, nonatomic) NSString *yelpRating;

@property (strong, nonatomic) NSString *googlePriceLevel;
@property (strong, nonatomic) NSString *fourSquarePriceLevel;

@property (strong, nonatomic) NSString *openNow;
@property (strong, nonatomic) UIImage *image;

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
                      Image:(UIImage *)image;
@end

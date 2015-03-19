//
//  FourSquares.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/17/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquares : NSObject

- (instancetype)initWithName:(NSString *)name
                    Latitude:(NSString *)latitude
                   Longitude:(NSString *)longitude
                     Address:(NSString *)address
                      Rating:(NSString *)rating
                         Url:(NSString *)url
                     Zipcode:(NSString *)zipCode
                 PhoneNumber:(NSString *)phoneNumber;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *ratingImage;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *zipCode; // maybe
@property (strong, nonatomic) NSString *phoneNumber;

@end

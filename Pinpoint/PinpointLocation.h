//
//  PinpointQuery.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/23/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PinpointLocation : NSObject
@property (strong,nonatomic) NSString *name;
@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@end

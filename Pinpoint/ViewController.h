//
//  ViewController.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/13/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *fourSquareResults;

@end


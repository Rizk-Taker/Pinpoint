//
//  ResultsViewController.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchInputViewController;

@interface ResultsViewController : UIViewController

@property (strong, nonatomic) NSArray *resultsArray;
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

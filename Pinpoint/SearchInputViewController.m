//
//  ViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/13/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "SearchInputViewController.h"
#import "AggregateDataStore.h"
#import "PinpointComparisonHelper.h"
#import "FourSquareAPIClient.h"
#import "GoogleAPIClient.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"

@interface SearchInputViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (strong, nonatomic) GoogleAPIClient *googleProxy;
@property (strong, nonatomic) FourSquareAPIClient *foursquareProxy;
@property (strong, nonatomic) YelpAPIClient *yelpProxy;

@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) PinpointComparisonHelper *pinpointComparisonHelper;
@property (strong, nonatomic) FourSquareAPIClient *foursquare;
@end

@implementation SearchInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.locationTextField.delegate = self;
    self.searchTextField.delegate = self;
    
    self.pinpointComparisonHelper = [[PinpointComparisonHelper alloc] init];
    
    self.googleProxy = [GoogleAPIClient sharedProxy];
    self.foursquareProxy = [FourSquareAPIClient sharedProxy];
    self.yelpProxy = [YelpAPIClient sharedProxy];
    
    [self.pinpointComparisonHelper combineResultsWithTerm:@"sushi" Latitiude:@"40.7127" Longitude:@"-74.0059" CompletionHandler:^(NSArray *pinPointArray) {
        NSLog(@"pinpointComparisonHelper in ViewDidLoad");
        self.results = pinPointArray;
        [self.myTableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@",self.locationTextField.text);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    myCell.textLabel.text = self.results[indexPath.row];
    
    return myCell;
}


@end

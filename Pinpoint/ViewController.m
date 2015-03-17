//
//  ViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/13/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ViewController.h"
//#import "FourSquareAPIClient.h"
#import "PinpointDataStore.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) PinpointDataStore *pinPointDataStore;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.locationTextField.delegate = self;
    self.searchTextField.delegate = self;
    
    self.pinPointDataStore = [PinpointDataStore sharedDataStore];
    
    [self.pinPointDataStore combineYelpandFoursquareResultsWithTerm:@"term" Location:@"location" CompletionHandler:^(NSArray *pinPointArray) {
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
    return [self.fourSquareResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    myCell.textLabel.text = self.fourSquareResults[indexPath.row];
    
    return myCell;
}

@end

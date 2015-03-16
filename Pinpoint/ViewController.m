//
//  ViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/13/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ViewController.h"
#import "FourSquareAPIClient.h"
#import "FourSquareDataStore.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) FourSquareDataStore *fourSquareDataStore;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.fourSquareDataStore = [FourSquareDataStore sharedDataStore];
    
    [self.fourSquareDataStore getFourSquareDataWithCompletionHandler:^void(NSArray *fourSquareArray) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.fourSquareResults = fourSquareArray;
            [self.myTableView reloadData];
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

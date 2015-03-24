//
//  ResultsViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ResultsViewController.h"
#import "GoogleAPIClient.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"
#import "SearchInputViewController.h"
#import "Pinpoint.h"
#import "PinpointComparisonHelper.h"
#import "ResultDetailViewController.h"

@interface ResultsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) PinpointComparisonHelper *pinpointComparisonHelper;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    self.pinpointComparisonHelper = [[PinpointComparisonHelper alloc] init];
    
    [self.pinpointComparisonHelper combineResultsWithTerm:self.query Latitiude: self.lat Longitude:self.lng CompletionHandler:^(NSArray *pinPointArray) {
        
        if ([pinPointArray count] > 0) {
            self.resultsArray = pinPointArray;
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.myTableView reloadData];
            }];
            
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No results found" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *popVC = [UIAlertAction actionWithTitle:@"Word" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [alertController addAction:popVC];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
 
        }
        
    }];
    [self.myTableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Pinpoint *pinpoint = self.resultsArray[indexPath.row];
    cell.textLabel.text = pinpoint.name;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     ResultDetailViewController *resultDetailVC = segue.destinationViewController;
     
     NSIndexPath *ip = [self.myTableView indexPathForSelectedRow];
     
     Pinpoint *pinPointToPass = self.resultsArray[ip.row];
     
     resultDetailVC.pinPoint = pinPointToPass;
     
     
 }


@end

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
#import "ResultsViewController.h"
#import "PinpointLocation.h"

#import "GoogleAPIClient.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"

@interface SearchInputViewController () <UITextFieldDelegate, SuggestedLocationsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (strong, nonatomic) PinpointComparisonHelper *pinpointComparisonHelper;
@property (strong, nonatomic) SuggestedLocationsViewController *suggestedVC;

@property (strong, nonatomic) PinpointLocation *location;



- (IBAction)pinpointTapped:(id)sender;

@end

@implementation SearchInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.locationTextField.delegate = self;
    self.searchTextField.delegate = self;
    
    self.location = [[PinpointLocation alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dataFromController:(NSString *)name Latitude:(CGFloat)latitude Longitude:(CGFloat)longitude {
    self.locationTextField.text = name;
    self.location.name = name;
    self.location.latitude = latitude;
    self.location.longitude = longitude;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.locationTextField) {
        self.suggestedVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SuggestedLocationsViewController"];
        self.suggestedVC.delegate = self;
        [self.navigationController pushViewController:self.suggestedVC animated:YES];
        
        return NO;
    }
    return YES;
}

- (IBAction)pinpointTapped:(id)sender {
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"pinpointComparisonHelper segueing");

    ResultsViewController *resultsVC = segue.destinationViewController;
    NSString *lat = [NSString stringWithFormat:@"%f", self.location.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", self.location.longitude];
    NSString *query = self.searchTextField.text;
    
    resultsVC.lat = lat;
    resultsVC.lng = lng;
    resultsVC.query = query;
    
    [resultsVC.myTableView reloadData];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"results"]) {
        if (self.location.latitude && self.location.longitude && self.location.name && self.searchTextField.text) {
            return YES;
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid search" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *popVC = [UIAlertAction actionWithTitle:@"Word" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            
            [alertController addAction:popVC];
            
            [self presentViewController:alertController animated:YES completion:nil];
     return NO;
        }
    }
    return YES;
}

@end

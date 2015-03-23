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

#import "GoogleAPIClient.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"

@interface SearchInputViewController () <UITextFieldDelegate, SuggestedLocationsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) PinpointComparisonHelper *pinpointComparisonHelper;
@property (strong, nonatomic) SuggestedLocationsViewController *suggestedVC;

- (IBAction)pinpointTapped:(id)sender;

@end

@implementation SearchInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.locationTextField.delegate = self;
    self.searchTextField.delegate = self;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dataFromController:(SPGooglePlacesAutocompletePlace *)data {
    self.locationTextField.text = data.name;
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
    
    self.pinpointComparisonHelper = [[PinpointComparisonHelper alloc] init];
    
    [self.pinpointComparisonHelper combineResultsWithTerm:@"sushi" Latitiude:@"40.7127" Longitude:@"-74.0059" CompletionHandler:^(NSArray *pinPointArray) {
        
        NSLog(@"pinpointComparisonHelper segueing");
        
        self.results = pinPointArray;
    }];
    
    ResultsViewController *resultsVC = segue.destinationViewController;
    resultsVC.resultsArray = self.results;
    
}

@end

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
#import "GoogleAPIClient.h"
#import "FourSquareAPIClient.h"
#import "YelpAPIClient.h"
#import "SuggestedLocationsViewController.h"

@interface SearchInputViewController () <SuggestedLocationsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

- (IBAction)pinpointTapped:(id)sender;


@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) PinpointComparisonHelper *pinpointComparisonHelper;

@property (strong, nonatomic) SuggestedLocationsViewController *suggestedVC;
@end

@implementation SearchInputViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.locationTextField.delegate = self;
    self.searchTextField.delegate = self;


    
    
//    self.pinpointComparisonHelper = [[PinpointComparisonHelper alloc] init];
//    
//    [self.pinpointComparisonHelper combineResultsWithTerm:@"sushi" Latitiude:@"40.7127" Longitude:@"-74.0059" CompletionHandler:^(NSArray *pinPointArray) {
//        NSLog(@"pinpointComparisonHelper in ViewDidLoad");
//        self.results = pinPointArray;
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dataFromController:(NSString *)data
{
    self.locationTextField.text = data;
}

- (void)passDataForward
{
    self.locationTextField.text =self.suggestedVC.data;
    self.suggestedVC.delegate = self; // Set the second view controller's delegate to self
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.suggestedVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SuggestedLocationsViewController"];;
    [self.navigationController pushViewController:self.suggestedVC animated:YES];
    return YES;
}

- (IBAction)pinpointTapped:(id)sender {
    
}
@end

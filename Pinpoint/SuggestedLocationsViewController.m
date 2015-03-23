//
//  SuggestedLocationsViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "SuggestedLocationsViewController.h"
#import "GoogleAPIClient.h"
#import "GooglePlace.h"
#import "SPGooglePlacesAutocompletePlace.h"

@interface SuggestedLocationsViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *autoCompleteTextField;
@property (weak, nonatomic) IBOutlet UITableView *autoCompleteTableView;
@property (strong, nonatomic) NSArray *googleAutoCompleteArray;

@end


@implementation SuggestedLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.googleAutoCompleteArray = [[NSArray alloc] init];
    
    self.autoCompleteTableView.delegate = self;
    self.autoCompleteTableView.dataSource = self;
    
    self.autoCompleteTextField.delegate = self;
    [self.autoCompleteTextField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.autoCompleteTextField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(NSNotification *)notification {
    // Do whatever you like to respond to text changes here.
    GoogleAPIClient *googleAPIClient = [GoogleAPIClient sharedProxy];
    [googleAPIClient handleSearchForSearchString:self.autoCompleteTextField.text withCompletionBlock:^(BOOL success, NSArray *places) {
        self.googleAutoCompleteArray = places;
        [self.autoCompleteTableView reloadData];
    }];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.googleAutoCompleteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    

    cellIdentifier = @"googleResult";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Current Location";
    } else {

    SPGooglePlacesAutocompletePlace *place = self.googleAutoCompleteArray[indexPath.row];
    cell.textLabel.text = place.name;
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        // pass in CLL Location stuff
    }
    
    SPGooglePlacesAutocompletePlace *place = self.googleAutoCompleteArray[indexPath.row];
    
    [self.delegate dataFromController:place];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

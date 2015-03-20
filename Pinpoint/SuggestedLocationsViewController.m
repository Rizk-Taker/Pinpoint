//
//  SuggestedLocationsViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "SuggestedLocationsViewController.h"

@interface SuggestedLocationsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *autoCompleteTextField;
@property (weak, nonatomic) IBOutlet UITableView *autoCompleteTableView;
@property (strong, nonatomic) NSMutableArray *googleAutoCompleteArray;

@end


@implementation SuggestedLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + [self.googleAutoCompleteArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    
    if (indexPath.row == 0) {
        cellIdentifier = @"currentLocation";
    }
    else {
        cellIdentifier = @"googleResult";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Current Location";
    } else {
        cell.textLabel.text = self.googleAutoCompleteArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // pass in CLL Location stuff
    }

    {
        if ([_delegate respondsToSelector:@selector(dataFromController:)])
        {
            [_delegate dataFromController:@"This data is from the second view controller."];
        }
        
    }
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

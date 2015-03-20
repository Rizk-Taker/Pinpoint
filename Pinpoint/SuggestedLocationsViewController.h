//
//  SuggestedLocationsViewController.h
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SuggestedLocationsViewControllerDelegate <NSObject>
@required
- (void)dataFromController:(NSString *)data;
@end

@interface SuggestedLocationsViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSString *data;
@property (nonatomic, weak) id<SuggestedLocationsViewControllerDelegate> delegate;
- (void)textFieldDidChange:(NSNotification *)notification;

@end

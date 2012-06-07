//
//  CustomerEditViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 17/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"
#import "CustomerDeleteDelegate.h"

@interface CustomerEditViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *addressValue;
@property (weak, nonatomic) IBOutlet UITextField *postcodeValue;
@property (weak, nonatomic) IBOutlet UITextField *numberValue;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (nonatomic, assign) id <CustomerDeleteDelegate> deleteDelegate;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) NSDate *dob;

-(IBAction)dateButtonPressed:(id)sender;
-(IBAction)switchStateChanged:(id)sender;
-(IBAction)deleteButtonPressed:(id)sender;

@end

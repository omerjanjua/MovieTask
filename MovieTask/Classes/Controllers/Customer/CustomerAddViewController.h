//
//  CustomerAddViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"

@interface CustomerAddViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *addressValue;
@property (weak, nonatomic) IBOutlet UITextField *postcodeValue;
@property (weak, nonatomic) IBOutlet UITextField *numberValue;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) NSDate *dob;

-(IBAction)dateButtonPressed:(id)sender;

@end

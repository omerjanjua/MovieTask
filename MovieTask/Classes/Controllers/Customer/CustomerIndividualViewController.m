//
//  CustomerIndividualViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerIndividualViewController.h"
#import "CustomerEditViewController.h"

@interface CustomerIndividualViewController ()
-(void)setupNav;
-(void)displayCustomerInfo;
@end

@implementation CustomerIndividualViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize accountLabel = _accountLabel;
@synthesize nameLabel = _nameLabel;
@synthesize addressLabel = _addressLabel;
@synthesize postcodeLabel = _postcodeLabel;
@synthesize numberLabel = _numberLabel;
@synthesize dateLabel = _dateLabel;
@synthesize stateLabel = _stateLabel;
@synthesize customer = _customer;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayCustomerInfo];
}

#pragma mark - setupNav
-(void)setupNav
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    self.navigationItem.rightBarButtonItem = button;  
    self.scrollView.contentSize = self.contentView.frame.size;
    NSString *title = [[NSString alloc] initWithString:@"Individual Customer"];
    self.navigationItem.title = title;
                
}
  
//while clicking on the rightbarbutton the edit view controller appears modally 
-(IBAction)editButtonPressed:(id)sender
{
    CustomerEditViewController *controller = [[CustomerEditViewController alloc] initWithNibName:@"CustomerEditView" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    Customer *customer = self.customer;//The instance of the customer entity is assigned to the controller. When the edit screen is displayed modally this line makes sure the information loaded is for the selected customer. 
    controller.customer = customer;
    controller.deleteDelegate = self;
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - displayCustomerInfo
//data from the model is displayed in the labels
-(void)displayCustomerInfo
{
    if (!self.customer) 
    {
        Customer *customer = [Customer createEntity];
        self.customer = customer;
    }
    self.accountLabel.text = self.customer.accountNo;
    self.nameLabel.text = self.customer.name;
    self.addressLabel.text = self.customer.address;
    self.postcodeLabel.text = self.customer.postcode;
    self.numberLabel.text = self.customer.number;
    
    
    if ([[self.customer.state stringValue] isEqualToString:@"1"]) 
    {
        self.stateLabel.text = @"Open";
    }
    else if ([[self.customer.state stringValue] isEqualToString:@"0"]) 
    {
        self.stateLabel.text = @"Close";
    }
    
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [date stringFromDate:self.customer.dob];
    self.dateLabel.text = stringFromDate;
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setAccountLabel:nil];
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [self setPostcodeLabel:nil];
    [self setNumberLabel:nil];
    [self setDateLabel:nil];
    [self setStateLabel:nil];
    [self setScrollView:nil];
    [self setContentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)customerDeleted //this method will display the main controller instead of modally dismissing the edit screen and displaying the individual screen when a customer is deleted. 
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

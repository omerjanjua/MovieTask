//
//  CustomerEditViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 17/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//some things i havent commented becuase they have already been commented in the add customer screen

#import "CustomerEditViewController.h"
#import "NSDate+Additions.h"
#import "Additions.h"
#import "RentalMovieViewController.h"

@interface CustomerEditViewController ()
-(void)setupNav;
-(void)setupKeyboard;
-(void)setValueForCustomer;
-(void)displayCustomerInfo;
-(void)customerDeleted;
-(BOOL)fieldIsValid:(NSString*)field;
-(BOOL)inputIsValid;

@end

@implementation CustomerEditViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize accountLabel = _accountLabel;
@synthesize nameValue = _nameValue;
@synthesize addressValue = _addressValue;
@synthesize postcodeValue = _postcodeValue;
@synthesize numberValue = _numberValue;
@synthesize dateLabel = _dateLabel;
@synthesize stateSwitch = _stateSwitch;
@synthesize datePicker = _datePicker;
@synthesize customer = _customer;
@synthesize dob = _dob;
@synthesize deleteDelegate = _deleteDelegate;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupKeyboard];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayCustomerInfo];
}

#pragma mark - setupNav
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;   //setting the cancel button as the left bar button
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;    //setting the done button as the right bar button
    
    NSString *title = [[NSString alloc] initWithString:@"Edit Customer"];
    self.navigationItem.title = title; //setting the title of the navbar
    
    self.scrollView.contentSize = self.contentView.frame.size; //setting the view within the scroll view to make the view scrollable 
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];  //pressing cancel will dismiss the modal view displaying main customer screen
}

-(IBAction)savePressed:(id)sender
{
    if ([self inputIsValid]) 
    {
        [self setValueForCustomer];
        [self.customer.managedObjectContext save];
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *validateAlert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Can you please enter a name, address and postcode please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validateAlert show];
    }
}


//At switch state change a validation is carried out which checks rentals are rented out on the customers account. 
- (IBAction)switchStateChanged:(id)sender 
{
    NSUInteger count =  [[Rental rentalsForCustomer:self.customer] count];
    
    //not self 
    if (self.stateSwitch.on && count == 0) 
    {

    }
    else if (count > 0)
    {
        UIAlertView *closeAlert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Cannot close customer account if  movies are still rented out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [closeAlert show];
        self.customer.state = [NSNumber numberWithBool:YES];
        [self.stateSwitch setOn:YES animated:YES];
    
    }
}


#pragma mark - setValueForCustomer
-(void)setValueForCustomer
{
    if (!self.customer) {
        Customer *customer = [Customer createEntity];
        self.customer = customer;
    }
    self.customer.name = self.nameValue.text;
    self.customer.address = self.addressValue.text;
    self.customer.postcode = self.postcodeValue.text;
    self.customer.number = self.numberValue.text;
    
    //saves what the final state of the switch is 
    if (self.stateSwitch.on) 
    {
        self.customer.state = [NSNumber numberWithBool:YES];   
    }
    else 
    {
        self.customer.state = [NSNumber numberWithBool:NO]; 
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationA" object:self];

    }
    
    //if the user doesnt change the dob then the original dob is saved back in the model. otherwise the value from the label is retireved 
    if (self.dob == Nil) {
            NSDateFormatter *date = [[NSDateFormatter alloc] init];
            [date setDateFormat:@"dd-MM-yyy"];
            NSDate *dateFromString = [date dateFromString:self.dateLabel.text];
            self.customer.dob = dateFromString;
    }
    else {
        self.customer.dob = self.dob;
    }
}

#pragma mark - deleting customer
//when the delete button is pressed a validation is carried out to check if the user still has any movies rented out. 
-(IBAction)deleteButtonPressed:(id)sender
{
    if (!self.customer) {   //if the customer entity does not exist create one
        Customer *customer = [Customer createEntity];
        self.customer = customer;
    }
    
    NSUInteger arrayCount = [[Rental rentalsForCustomer:self.customer] count];
    if (arrayCount > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Cannot delete the customer, while movies are rented out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (arrayCount == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Customer" message:@"Are you sure" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
        [alert show];
    }
}

//entity is deleted if the user selects yes from the alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Delete Customer"]) 
    {
        if (buttonIndex == 1) 
        {
            [self.customer deleteEntity];
            [self.customer.managedObjectContext save];
            [self dismissModalViewControllerAnimated:YES];//dismiss to the customerview controller not the individual customer view controller
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationA" object:self];
            [self customerDeleted];
        }
    }
}

//using the customer deletee delegate protocol
-(void)customerDeleted
{
    if ([self.deleteDelegate respondsToSelector:@selector(customerDeleted)]) {
        [self.deleteDelegate customerDeleted];
    }
}

#pragma mark - displayCustomerInfo
//retrieve the values from the model and display them in the textfields. 
-(void)displayCustomerInfo
{
    if (!self.customer) {
        Customer *customer = [Customer createEntity];
        self.customer = customer;
    }
    self.accountLabel.text = self.customer.accountNo;
    self.nameValue.text = self.customer.name;
    self.addressValue.text = self.customer.address;
    self.postcodeValue.text = self.customer.postcode;
    self.numberValue.text = self.customer.number;
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [date stringFromDate:self.customer.dob];
    self.dateLabel.text = stringFromDate;

    
    NSUInteger state = [self.customer.state integerValue];
    
    if (state == 1) {
        [self.stateSwitch setOn:YES animated:YES];
    }
    else {
        [self.stateSwitch setOn:NO animated:YES];
    }

}

#pragma mark - keyboard
-(void)setupKeyboard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
-(IBAction)dismissKeyboard:(id)sender
{
    [self.nameValue resignFirstResponder];
    [self.addressValue resignFirstResponder];
    [self.postcodeValue resignFirstResponder];
    [self.numberValue resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameValue) 
    {
        [self.addressValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 90) animated:YES]; //pushes on the scrollview down when returned is clicked on the name text field so the next textfield in line is visible 
    }
    else if (textField == self.addressValue) 
    {
        [self.postcodeValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    else if (textField == self.postcodeValue) 
    {
        [self.numberValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
    }
    else 
    {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return NO;
}

#pragma mark - DatePickerView
-(IBAction)dateButtonPressed:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Please select a date of birth" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 185, 0, 0)];
    self.datePicker = datePicker;
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [menu addSubview:datePicker];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDate *date = [self.datePicker date];
        NSString *dateString = [NSDate stringFromDateWithFormat:date format:@"dd/MM/yyyy"];
        self.dateLabel.text = [NSString stringWithFormat:@"%@", dateString];
        self.dob = [NSDate dateFromStringWithFormat:dateString format:@"dd/MM/yyyy"];//saving the date to the property created which is later called in the set value method so the value which is taken at this point is then saved to the model in the set value method.
    }
}

#pragma mark - Validate
-(BOOL) fieldIsValid:(NSString *)field
{
    BOOL fieldIsNil = field == Nil;
    BOOL fieldIsEmpty = [field isEqualToString:@""];
    return !fieldIsEmpty && !fieldIsNil;
}

-(BOOL) inputIsValid
{    
    BOOL nameIsValid = [self fieldIsValid:[self.nameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    BOOL addressIsValid = [self fieldIsValid:[self.addressValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    BOOL postcodeIsValid = [self fieldIsValid:[self.postcodeValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    BOOL isValid = nameIsValid && addressIsValid && postcodeIsValid;
    
    return isValid;
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setAccountLabel:nil];
    [self setNameValue:nil];
    [self setAddressValue:nil];
    [self setPostcodeValue:nil];
    [self setNumberValue:nil];
    [self setDateLabel:nil];
    [self setStateSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end

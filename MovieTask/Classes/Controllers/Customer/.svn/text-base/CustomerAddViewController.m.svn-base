//
//  CustomerAddViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerAddViewController.h"
#import "NSDate+Additions.h"

@interface CustomerAddViewController ()
-(void)setupNav;
-(void)setupKeyboard;
-(void)setValueForCustomer;
-(BOOL)fieldIsValid:(NSString*)field;
-(BOOL)inputIsValid;

@end

@implementation CustomerAddViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize addressValue = _addressValue;
@synthesize postcodeValue = _postcodeValue;
@synthesize numberValue = _numberValue;
@synthesize dateLabel = _dateLabel;
@synthesize customer = _customer;
@synthesize datePicker = _datePicker;
@synthesize dob = _dob;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupKeyboard];
}

#pragma mark - setupNav
//this method sets the title of the screen with the right bar button and left bar button 
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;   //setting the cancel button as the left bar button
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;    //setting the done button as the right bar button
    
    NSString *title = [[NSString alloc] initWithString:@"Add Customer"];
    self.navigationItem.title = title; //setting the title of the navbar
    
    self.scrollView.contentSize = self.contentView.frame.size; //setting the view within the scroll view to make the view scrollable 
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];  //pressing cancel will dismiss the modal view displaying main customer screen
}

//this methos forst checks weather the validation has passed, once true the values from the textfields are assigned to the attributes in the model and saved. 
//if the validation does not pass an alertview appears 
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Can you please enter a name, address and postcode please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - setValueForCustomer
//this creates the entity and then assigns the valur from the textfields to the objects in the model.
-(void)setValueForCustomer
{
    if (!self.customer) {
        Customer *customer = [Customer createEntity];
        self.customer = customer;
    }
    
    self.customer.accountNo = [Customer newAccountNumber];
    self.customer.name = self.nameValue.text;
    self.customer.address = self.addressValue.text;
    self.customer.postcode = self.postcodeValue.text;
    self.customer.number = self.numberValue.text;
    self.customer.state = [NSNumber numberWithBool:YES];
    self.customer.dob = self.dob;//retrieveing the value from the property, much less code than what is below
//    NSDateFormatter *date = [[NSDateFormatter alloc] init];
//    [date setDateFormat:@"dd-MM-yyy"];
//    NSDate *dateFromString = [date dateFromString:self.dateLabel.text];
//    self.customer.dob = dateFromString;
}

#pragma mark - keyboard
//by clicking anywhere outside the textfield the keyboard dismisses
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

//when the return key is pressed on the keyboard the next textfield becomes the active textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameValue) 
    {
        [self.addressValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 70) animated:YES]; //pushes on the scrollview down when returned is clicked on the name text field so the next textfield in line is visible 
    }
    else if (textField == self.addressValue) 
    {
        [self.postcodeValue becomeFirstResponder];
    }
    else if (textField == self.postcodeValue) 
    {
        [self.numberValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
    }
    else 
    {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES]; //after the last return key the view is reset to the top ofthe screen 
    }
    return YES;
}

#pragma mark - DatePickerView
//by pressing this button an actionsheet is displayed with a picker view as a subview so a dont button is avaialable to dismiss the pickerview.
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

//by clicking the done button the actionsheet the value of the pickerview is assigned to the textfield. 
//the value is saved to a property which is then used to save the value to the model in the save method instead of doing saves in multiple places 
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
//this methos checks for if the fields are empty or nil 

-(BOOL) fieldIsValid:(NSString *)field
{
    BOOL fieldIsNil = field == Nil;
    BOOL fieldIsEmpty = [field isEqualToString:@""];
    return !fieldIsEmpty && !fieldIsNil;
}

//this method checks for any white spaces entered in the text field. and checks weather all textfields have data in them. 
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
    //these have been automatically put here when the xib connections were made
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setNameValue:nil];
    [self setAddressValue:nil];
    [self setPostcodeValue:nil];
    [self setDateLabel:nil];
    [self setNumberValue:nil];
    [super viewDidUnload];
}

@end

//
//  MovieAddViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//most of the things have already been explained in the earlier controllers, avoiding repetition of commenting and cluttering the code. 
#import "MovieAddViewController.h"
#import "MoviePhotoViewController.h"
#import "ImageToDataTransformer.h"

@interface MovieAddViewController ()
-(void)setupNav;
-(void)setupKeyboard;
-(void)pickerArrays;
-(void)setValueForMovie;
-(BOOL)fieldIsValid:(NSString*)field;
-(BOOL)inputIsValid;

@end

@implementation MovieAddViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize castValue = _castValue;
@synthesize directorValue = _directorValue;
@synthesize ratingLabel = _ratingLabel;
@synthesize quantityLabel = _quantityLabel;
@synthesize imageButton = _imageButton;
@synthesize pickerType = _pickerType;
@synthesize ratingArray = _ratingArray;
@synthesize quantityArray = _quantityArray;
@synthesize pickerView = _pickerView;
@synthesize movie = _movie;
@synthesize movieCopy = _movieCopy;
@synthesize rating = _rating;
@synthesize picture = _picture;
@synthesize quantity = _quantity;
@synthesize ratingIndex = _ratingIndex;
@synthesize quantityIndex = _quantityIndex;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupKeyboard];
    [self pickerArrays];
}

#pragma mark - setupNav
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;
    
    NSString *title = [[NSString alloc] initWithString:@"Add Movie"];
    self.navigationItem.title = title;
    
    self.scrollView.contentSize = self.contentView.frame.size;
}
                                     
-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
                                     
-(IBAction)savePressed:(id)sender
{
    
    if ([self inputIsValid]) 
    {
        [self setValueForMovie];
        [self.movie.managedObjectContext save];
        [self dismissModalViewControllerAnimated:YES];
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Can you please enter a name, quantity please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }   
}

#pragma mark - setValueForMovie
-(void)setValueForMovie
{
    if (!self.movie) {
        Movie *movie = [Movie createEntity];
        self.movie = movie;
    }
    self.movie.name = self.nameValue.text;
    self.movie.cast = self.castValue.text;
    self.movie.director = self.directorValue.text;
    self.movie.rating = self.rating;//retrieving the value from the rating property which was assigned when the done button was vclickined on the picker view. 
    self.movie.identifier = self.picture;
    
    for (int i=0; i<[self.quantityLabel.text intValue]; i++) 
    {
        Copy * copy = [Copy createEntity];
        copy.identifier = [Movie newCopyNumber];
        copy.movie = self.movie;
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
    [self.castValue resignFirstResponder];
    [self.directorValue resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameValue) {
        [self.castValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 150) animated:YES];
    }
    else if (textField == self.castValue) {
        [self.directorValue becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
    return NO;
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
    BOOL quantityIsValid = [self fieldIsValid:[self.quantityLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    BOOL isValid = nameIsValid && quantityIsValid;
    
    return isValid;
}

#pragma mark - AlbumArt
-(IBAction)albumArtButtonPressed:(id)sender
{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
}


//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo 
{   
    self.imageButton.imageView.image = selectedImage; //once an image is selected it is displayed on the button. 
    
    CGSize size = selectedImage.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 44.0 / size.width;
    } else {
        ratio = 44.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio *size.width, ratio*size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [selectedImage drawInRect:rect];
    self.picture = selectedImage;
    UIGraphicsEndImageContext();
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - Rating
-(IBAction)ratingButtonPressed:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Please Select a Rating" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 185, 0, 0)];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;

    self.pickerView = pickerView;//assigning the value of the view to the property then using the property to display clicked button at index
    self.pickerType = RatingPicker; //call this before its added to the subview so the enum is assigned properly
    [self.pickerView selectRow:self.ratingIndex inComponent:0 animated:NO];//loads the pickerview at the selected value 
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

#pragma mark - Quantity
-(IBAction)quantityButtonPressed:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Please Select a Quantity" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 185, 0, 0)];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    self.pickerView = pickerView;
    self.pickerType = QuantityPicker; 
    [self.pickerView selectRow:self.quantityIndex inComponent:0 animated:NO];//loads the pickerview at the selected value 
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

#pragma mark - PickerArrays
-(void)pickerArrays
{
    NSArray *rating = [[NSArray alloc] initWithObjects:@"U", @"PG", @"12", @"15", @"18", nil];
    self.ratingArray = rating;
    

    NSMutableArray *mutableQuantity = [NSMutableArray array];   //creating a mutablearray outside the loop so a new array is not created each time a loop is ran
    int x;  //create an int variable (scalar type)
    for (x=1; x<=20; x = x+1) //conditions: initially 1, if less than 20 keep running
    {
        NSString *string = [NSString stringWithFormat:@"%d", x];    //passing the int though an int becuase the pickverview requires a string type returned. 
       // NSNumber *quantityNumber = [NSNumber numberWithInt:x];  //declate a nsnumber to pass in the int declared 
        [mutableQuantity addObject:string]; //int is not an object so assigning it to an nsnumber and passing that through to my mutable array
    }
        self.quantityArray = mutableQuantity;   //assigning the value to the arrayi want to display in the picker view. 
}

#pragma mark - PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //making use of enums to see which array to load depending on the pickerview selected. 
    if (self.pickerType == RatingPicker) {
        return [self.ratingArray count];
    }
    else {
        return [self.quantityArray count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerType == RatingPicker) 
    {
        return [self.ratingArray objectAtIndex:row];
    }
    else 
    {
        return [self.quantityArray objectAtIndex:row];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {
        if (self.pickerType == RatingPicker) 
        {
            NSInteger row = [self.pickerView selectedRowInComponent:0];
            self.rating  = [self.ratingArray objectAtIndex:row];
            self.ratingIndex = row; //saving the value to my property so when the button is clicked the picker loads at the selected value
            self.ratingLabel.text = self.rating;
        }
        else if (self.pickerType == QuantityPicker) 
        {
            NSInteger row = [self.pickerView selectedRowInComponent:0];
            self.quantity = [self.quantityArray objectAtIndex:row];
            self.quantityIndex = row;
            self.quantityLabel.text = self.quantity;
        }
    }
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setNameValue:nil];
    [self setCastValue:nil];
    [self setDirectorValue:nil];
    [self setRatingLabel:nil];
    [self setQuantityLabel:nil];
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setImageButton:nil];
    [super viewDidUnload];
}
@end

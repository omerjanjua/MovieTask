//
//  MovieEditViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieEditViewController.h"

@interface MovieEditViewController ()
-(void)setupNav;
-(void)setupKeyboard;
-(void)pickerArray;
-(void)setValueForMovie;
-(void)displayMovieInfo;
-(void)movieDeleted;
-(BOOL)fieldIsValid:(NSString*)field;
-(BOOL)inputIsValid;
@end

@implementation MovieEditViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize castValue = _castValue;
@synthesize directorValue = _directorValue;
@synthesize ratingLabel = _ratingLabel;
@synthesize imageButton = _imageButton;
@synthesize pickerView = _pickerView;
@synthesize ratingArray = _ratingArray;
@synthesize movie = _movie;
@synthesize rating = _rating;
@synthesize picture = _picture;
@synthesize deleteDelegate = _deleteDelegate;
@synthesize ratingIndex = _ratingIndex;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupKeyboard];
    [self pickerArray];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayMovieInfo];
}


#pragma mark - setupNav
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;   //setting the cancel button as the left bar button
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;    //setting the done button as the right bar button
    
    NSString *title = [[NSString alloc] initWithString:@"Edit Movie"];
    self.navigationItem.title = title; //setting the title of the navbar
    
    self.scrollView.contentSize = self.contentView.frame.size; //setting the view within the scroll view to make the view scrollable 
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];  //pressing cancel will dismiss the modal view displaying main movie screen
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Can you please enter a name please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - setValueForMovie
-(void)setValueForMovie
{
    if (!self.movie) 
    {
        Movie *movie = [Movie createEntity];
        self.movie = movie;
    }
    self.movie.name = self.nameValue.text;
    self.movie.cast = self.castValue.text;
    self.movie.director = self.directorValue.text;

    if (self.picture == Nil) 
    {

    }
    else 
    {
        self.movie.identifier = self.picture;
    }

    if (self.rating == Nil) {
        self.movie.rating = self.ratingLabel.text;
    }
    else {
        self.movie.rating = self.rating;//retrieveing the value from the property
    }    
}

#pragma mark - deleting movie
-(IBAction)deleteButtonPressed:(id)sender
{
    if (!self.movie) {
        Movie *movie = [Movie createEntity];
        self.movie = movie;
    }
    
    NSUInteger arrayCount = [[Copy copiesRentedOut:self.movie] count];
    if (arrayCount > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Cannot delete the movie, while copies are rented out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (arrayCount == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Movie" message:@"Are you sure" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Delete Movie"]) {
        if (buttonIndex == 1) {
            [self.movie deleteEntity];
            [self.movie.managedObjectContext save];
            [self dismissModalViewControllerAnimated:YES];
            [self movieDeleted];//once the movie entity is deleted the delegate method is called allowing the previous screen to pop off the view to present the main controller
        }
    }
}

-(void)movieDeleted
{
    if ([self.deleteDelegate respondsToSelector:@selector(movieDeleted)]) {
        [self.deleteDelegate movieDeleted];
    }
}

#pragma mark - displayMovieInfo
-(void)displayMovieInfo
{
    if (!self.movie) {
        Movie *movie = [Movie createEntity];
        self.movie = movie;
    }
    self.nameValue.text = self.movie.name;
    self.castValue.text = self.movie.cast;
    self.directorValue.text = self.movie.director;
    self.ratingLabel.text = self.movie.rating;    
    self.imageButton.imageView.image = self.movie.identifier;

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
    if (textField == self.nameValue) 
    {
        [self.castValue becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 150) animated:YES]; //pushes on the scrollview down when returned is clicked on the name text field so the next textfield in line is visible 
    }
    else if (textField == self.castValue) 
    {
        [self.directorValue becomeFirstResponder];
    }
    else 
    {
        [textField resignFirstResponder];
       [self.scrollView setContentOffset:CGPointMake(0, 130) animated:YES];
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
    return nameIsValid;
}

#pragma mark - AlbumArt
-(IBAction)albumArtButtonPressed:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo 
{       
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
    self.imageButton.imageView.image = selectedImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.imageButton.imageView.image = self.picture;
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - RatingPickerView
-(IBAction)ratingButtonPressed:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Please Select a Rating" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 185, 0, 0)];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    self.pickerView = pickerView;//assigning the value of the view to the property then using the property to display clicked button at index
    [self.pickerView selectRow:self.ratingIndex inComponent:0 animated:NO];//loads the pickerview at the selected value 
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

#pragma mark - PickerArray
-(void)pickerArray
{
    NSArray *rating = [[NSArray alloc] initWithObjects:@"U", @"PG", @"12", @"15", @"18", nil];
    self.ratingArray = rating;
}

#pragma mark - PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.ratingArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.ratingArray objectAtIndex:row];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        self.rating  = [self.ratingArray objectAtIndex:row];
        self.ratingIndex = row;
        self.ratingLabel.text = self.rating;
    }
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setNameValue:nil];
    [self setCastValue:nil];
    [self setDirectorValue:nil];
    [self setRatingLabel:nil];
    [self setImageButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end

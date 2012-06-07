//
//  RentalAddViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalAddViewController.h"
#import "RentalAddTableCell.h"
@interface RentalAddViewController ()
-(void)setupNav;
-(void)pickerArrays;
-(void)setRentalValues;
-(BOOL)fieldIsValid:(NSString*)field;
-(BOOL)inputIsValid;

@end

@implementation RentalAddViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize tableView = _tableView;
@synthesize nightsLabel = _nightsLabel;
@synthesize pickerView = _pickerView;
@synthesize nightsArray = _nightsArray;
@synthesize moviesArray = _moviesArray;
@synthesize nightString = _nightString;
@synthesize rental = _rental;
@synthesize selectedMovies = _selectedMovies;
@synthesize movieCopy = _movieCopy;
@synthesize movie = _movie;
@synthesize customer = _customer;
@synthesize nightsIndex = _nightsIndex;


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self pickerArrays];
    self.selectedMovies = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.moviesArray = [Movie availableMovies]; //sorting the customer first name in ascending order. /////findAllSortedBy:@"name" ascending:YES
    [self.tableView reloadData]; //reloads the rows of the table view
}

#pragma mark - setupNav
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;
    
    NSString *title = [[NSString alloc] initWithString:@"Add Rental"];
    self.navigationItem.title = title;
    
    self.scrollView.contentSize = self.contentView.frame.size;
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

//this methos saves the rental values if the validation passes
-(IBAction)savePressed:(id)sender
{
    NSUInteger arrayCount = [self.selectedMovies count];
    
    if ([self inputIsValid] && arrayCount > 0) 
    {
        [self setRentalValues];
        [self dismissModalViewControllerAnimated:YES];
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Can you please select a movie and number of nights please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)setRentalValues
{
    for (Movie *movie in self.selectedMovies) //for earch movie object in the selected movies array
    {
        Rental *rental = [Rental createEntity];//created my rental object

        rental.movieCopy = [[Copy availableCopies:movie] lastObject];//using the relationship to assigned my available copies to my rental object
        
        rental.customer = self.customer; //using the relationship to assign my customer to my rental object.
        
        rental.nights = [NSNumber numberWithInt:[self.nightString intValue]];//assigning the number of nights to my rental object so the copy has a specific number of nights its rented out for.
        
        rental.rented = [NSNumber numberWithBool:YES];//set the rented attribute to yes so the movie is rented out
        
        rental.rentedDate = [NSDate date];//set todays date on which the movie is rented out on 

        [rental.managedObjectContext save];//saving my rental object.        
    }
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.moviesArray) {
        return [self.moviesArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RentalTableCell";
    
    RentalAddTableCell *cell = (RentalAddTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (RentalAddTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"RentalAddTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Movie *movie = [self.moviesArray objectAtIndex:indexPath.row];
    cell.name.text = movie.name;
    cell.albumArt.image = movie.identifier;
    
    if ([self.selectedMovies containsObject:movie]) //if a selected movie object is in the array then display the tick else display the cross
    {
        cell.state.image = [UIImage imageNamed:@"tick.jpg"];
    }
    else {
        cell.state.image = [UIImage imageNamed:@"white_background.jpg"];
    } 
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *movie = [self.moviesArray objectAtIndex:indexPath.row];
   
    if ([self.selectedMovies containsObject:movie]) { //each time the row is selected either add the objected as selecetd object in selected movies array or remove the object
        [self.selectedMovies removeObject:movie];

    }
    else {
        NSUInteger rentedMovies = [[Rental rentalsForCustomer:self.customer]count];   //value one
        NSUInteger arrayCount = [self.selectedMovies count]; //value 2
        NSUInteger totalCount = (rentedMovies + arrayCount); //validation carried out by calculating both values of the movies
        
        if (totalCount < 3) {
            [self.selectedMovies addObject:movie];
        }
        else {//if validation fails display this alertview
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Only a maximum of 3 movies are allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];  
        }
        
    }   
    [tableView reloadData];//reload the tableview everytime the object is added or deleted from the array
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

#pragma mark - Nights Picker
-(IBAction)nightsButtonPressed:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Please select the number of nights" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 185, 0, 0)];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    self.pickerView = pickerView;//assigning the value of the view to the property then using the property to display clicked button at index
    [self.pickerView selectRow:self.nightsIndex inComponent:0 animated:NO];//loads the pickerview at the selected value 
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

-(void)pickerArrays
{
    NSArray *nights = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    self.nightsArray = nights;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.nightsArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.nightsArray objectAtIndex:row];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        self.nightString = [self.nightsArray objectAtIndex:row];
        self.nightsIndex = row;
        self.nightsLabel.text = self.nightString;
    }
}

#pragma mark - Validation
-(BOOL)fieldIsValid:(NSString*)field
{
    BOOL fieldIsNil = field == Nil;
    BOOL fieldIsEmpty = [field isEqualToString:@""];
    return !fieldIsEmpty && !fieldIsNil;
}

-(BOOL)inputIsValid
{
    BOOL nightsValid = [self fieldIsValid:self.nightsLabel.text];

    return nightsValid;
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setNightsLabel:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

@end

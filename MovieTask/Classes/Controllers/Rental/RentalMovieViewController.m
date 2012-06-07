//
//  RentalMovieViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalMovieViewController.h"
#import "RentalAddViewController.h"
#import "RentalIndividualViewController.h"

@interface RentalMovieViewController ()
-(void)setupNav;
-(void)accountClosed;

@end

@implementation RentalMovieViewController
@synthesize customer = _customer;
@synthesize rentalArray = _rentalArray;


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountClosed) name:@"notificationA" object:nil];

    
    [self setupNav];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.rentalArray = [Rental rentalsForCustomer:self.customer]; //only display the list of movies rented out by that customer. 
    [self.tableView reloadData]; 
}

#pragma mark - setupAdd
-(void)setupNav
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRental:)];
    self.navigationItem.rightBarButtonItem = button;
    NSString *string = [[NSString alloc] initWithString:@"Rented Movies"];
    self.navigationItem.title = string;
}

-(IBAction)addRental:(id)sender
{
    RentalAddViewController *controller = [[RentalAddViewController alloc] initWithNibName:@"RentalAddView" bundle:nil];
    controller.customer = self.customer;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rentalArray) {
        return [self.rentalArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Rental *rental = [self.rentalArray objectAtIndex:indexPath.row];
    cell.textLabel.text = rental.movieCopy.movie.name;
    UIFont *myFont = [UIFont systemFontOfSize:17]; //increase the font size to make it look consistent all across the app
    cell.textLabel.font = myFont;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    RentalIndividualViewController *controller = [[RentalIndividualViewController alloc] initWithNibName:@"RentalIndividualView" bundle:nil];
        Rental *rental = [self.rentalArray objectAtIndex:indexPath.row];

    controller.rental = rental;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)accountClosed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ViewDidUnload
- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end

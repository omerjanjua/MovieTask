//
//  RentalViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalViewController.h"
#import "RentalMovieViewController.h"
#import "CustomerEditViewController.h"
@interface RentalViewController ()
-(void)setupNav;
@end

@implementation RentalViewController
@synthesize customer = _customer;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.customer = [Customer openAccounts]; //only showing customer with open accounts on this screen. 
    [self.tableView reloadData]; //reloads the rows of the table view
    
}

#pragma mark - setupNav
-(void)setupNav
{
    NSString *string = [[NSString alloc] initWithString:@"Rental Screen"];
    self.navigationItem.title = string;
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.customer) {
        return [self.customer count];
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
    
    Customer *customer = [self.customer objectAtIndex:indexPath.row];
    cell.textLabel.text = customer.name;
    UIFont *myFont = [UIFont systemFontOfSize:17]; //to make sure the screen fonts are consisten throughout the app. 
    cell.textLabel.font = myFont;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Customer *customer = [self.customer objectAtIndex:indexPath.row];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    RentalMovieViewController *controller = [[RentalMovieViewController alloc] initWithNibName:@"RentalMovieView" bundle:nil];
    

    
    controller.customer = customer;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end

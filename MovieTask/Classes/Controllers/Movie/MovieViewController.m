//
//  MovieViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableCell.h"
#import "MovieAddViewController.h"
#import "MovieIndividualViewController.h"

@interface MovieViewController ()
-(void)setupNav;
@end

@implementation MovieViewController
@synthesize movie = _movie;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.movie = [Movie findAllSortedBy:@"name" ascending:YES]; //sorts all the movies out in alpha order
    [self.tableView reloadData]; //reloads the rows of the tableview once they're off the screen. saves memory build up
}

#pragma mark - setupAdd
-(void)setupNav
{
    //setting the right bar button as a + button which navigates the user to the add customer screen
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMovie:)];
    self.navigationItem.rightBarButtonItem = button;
    NSString *title = [[NSString alloc] initWithString:@"Movie Screen"];
    self.navigationItem.title = title; //assignning a title to the navbar
}

-(IBAction)addMovie:(id)sender
{
    MovieAddViewController *controller = [[MovieAddViewController alloc] initWithNibName:@"MovieAddView" bundle:nil];
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
    if (self.movie) {
        return [self.movie count]; //the number of rows in section should be the size of the array
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //custom table cell being used for each cell
    static NSString *CellIdentifier = @"MovieCell";
    
    MovieTableCell *cell = (MovieTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = (MovieTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"MovieTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Movie *movies = [self.movie objectAtIndex:indexPath.row];

    cell.name.text = movies.name;
///TK-4    
    
    
    NSArray *array = [Copy copiesRentedOut:movies];
    cell.stock.text = [NSString stringWithFormat:@"Rented: %d / Total: %d", [array count] ,[movies.copies count]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0; //expanding the height of each row since the custom table cell is bigger than the normal cell height
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    MovieIndividualViewController *controller = [[MovieIndividualViewController alloc] initWithNibName:@"MovieIndividualView" bundle:nil];
    
    Movie *movie = [self.movie objectAtIndex:indexPath.row];//when you click on the row the model knws which specific row you have selected.
    controller.movie = movie;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end

//
//  CustomerViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerViewController.h"
#import "Additions.h"
#import "CustomerTableCell.h"
#import "CustomerAddViewController.h"
#import "CustomerIndividualViewController.h"
#import "CustomerInfoViewController.h"

@interface CustomerViewController ()
-(void)setupNav;
@end

@implementation CustomerViewController

@synthesize customer = _customer;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

//when the view appears on the screen the customer names are sorted and displayed in alphabetical order. 
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.customer = [Customer findAllSortedBy:@"name" ascending:YES]; //sorting the customer first name in ascending order. 
    [self.tableView reloadData]; //reloads the rows of the table view
}

#pragma mark - setupAdd
-(void)setupNav
{
    //setting the right bar button as a + button which navigates the user to the add customer screen
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCustomer:)];
    self.navigationItem.rightBarButtonItem = button;

    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *info = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setLeftBarButtonItem:info animated:YES];
    
    
    NSString *title = [[NSString alloc] initWithString:@"Customer Screen"];
    self.navigationItem.title = title;
}

//pressing this button modally brings up the customer add new controller
-(IBAction)addCustomer:(id)sender
{
    CustomerAddViewController *controller = [[CustomerAddViewController alloc] initWithNibName:@"CustomerAddView" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentModalViewController:navController animated:YES];
}

//pressing this button modally brings up the pdf project spec in a uiwebview
-(IBAction)infoButton:(id)sender
{
    CustomerInfoViewController *controller = [[CustomerInfoViewController alloc] initWithNibName:@"CustomerInfoView" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    NSURL *url = nil;
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Document" ofType:@"pdf"]];
    controller.link = url;
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//the number of rows displayed on the table view is the length of the array
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.customer) {
        return [self.customer count];
    }
    return 0;
}

//custom table cell used which contains a label and a imageframe
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //setting the custom cell
    static NSString *CellIdentifier = @"CustomerCell";
    
    CustomerTableCell *cell = (CustomerTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = (CustomerTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"CustomerTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Customer *customer = [self.customer objectAtIndex:indexPath.row];
    cell.name.text = customer.name;

    if ([customer.state boolValue]) 
    {
        cell.state.image = [UIImage imageNamed:@"tick.jpg"];
    }
    else 
    {
        cell.state.image = [UIImage imageNamed:@"cross.jpg"];   
    }
    return cell;
}

//the height of the cell increased due to the label and image size being larger than 44px high 88px on retina
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

//clicking on the cell the user is navigated to the individual customer screen
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    CustomerIndividualViewController *controller = [[CustomerIndividualViewController alloc] initWithNibName:@"CustomerIndividualView" bundle:nil];
    
    Customer *customer = [self.customer objectAtIndex:indexPath.row];//these 2 lines of code specify what specific customer you are clicking on and when it goes in the individual controller information for the chosen customer will be displayed
    controller.customer = customer;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end

//
//  RentalIndividualViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalIndividualViewController.h"

@interface RentalIndividualViewController ()
-(void)setupNav;
-(void)displayMovieInfo;
@end

@implementation RentalIndividualViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize movieLabel = _movieLabel;
@synthesize nightsLabel = _nightsLabel;
@synthesize priceLabel = _priceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize rental = _rental;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayMovieInfo];
}

#pragma mark - setupNav
-(void)setupNav
{
    NSString *title = [[NSString alloc] initWithString:@"Individual Movie"];
    self.navigationItem.title = title;
    self.scrollView.contentSize = self.contentView.frame.size;
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)displayMovieInfo
{
    self.movieLabel.text = self.rental.movieCopy.movie.name;
    self.nightsLabel.text = [self.rental.nights stringValue];
    self.priceLabel.text = [self.rental rentalPrice];
    self.dateLabel.text = [self.rental dueDateString];
}

-(IBAction)savePressed:(id)sender
{
    if (!self.rental) 
    {
        Rental *rental = [Rental createEntity];
        self.rental = rental;
    }
    self.rental.rented = [NSNumber numberWithBool:NO];
    [self.rental.managedObjectContext save];
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setContentView:nil];
    [self setMovieLabel:nil];
    [self setNightsLabel:nil];
    [self setPriceLabel:nil];
    [self setDateLabel:nil];
    [super viewDidUnload];
}

@end

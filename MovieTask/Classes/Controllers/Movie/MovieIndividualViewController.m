//
//  MovieIndividualViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieIndividualViewController.h"
#import "MovieEditViewController.h"
#import "MoviePhotoViewController.h"

@interface MovieIndividualViewController ()
-(void)setupNav;
-(void)displayMovieInfo;
@end

@implementation MovieIndividualViewController

@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameLabel = _nameLabel;
@synthesize castLabel = _castLabel;
@synthesize directorLabel = _directorLabel;
@synthesize ratingLabel = _ratingLabel;
@synthesize quantityLabel = _quantityLabel;
@synthesize movie = _movie;
@synthesize movieCopy = _movieCopy;


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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    self.navigationItem.rightBarButtonItem = button;
    self.scrollView.contentSize = self.contentView.frame.size;
    NSString *title = [[NSString alloc] initWithString:@"Individual Movie"];
    self.navigationItem.title = title;
}

-(IBAction)editButtonPressed:(id)sender
{
    MovieEditViewController *controller = [[MovieEditViewController alloc] initWithNibName:@"MovieEditView" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    Movie *movie = self.movie; //so wen the edit screen is loaded the controller knows for which specific movie to display the information for. 
    controller.movie = movie;
    controller.deleteDelegate = self;
    [self.navigationController presentModalViewController:navController animated:YES];
}

-(void)movieDeleted
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AlbumArt
-(IBAction)albumArtButtonPressed:(id)sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    MoviePhotoViewController *controller = [[MoviePhotoViewController alloc] init];
    controller.movie = self.movie; //load this line from wherever the image is saved.
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - displayMovieInfo
-(void)displayMovieInfo
{
    self.nameLabel.text = self.movie.name;
    self.castLabel.text = self.movie.cast;
    self.directorLabel.text = self.movie.director;
    self.ratingLabel.text = self.movie.rating;
    self.quantityLabel.text = [NSString stringWithFormat:@"%d", [self.movie.copies count]];
}

#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setCastLabel:nil];
    [self setDirectorLabel:nil];
    [self setRatingLabel:nil];
    [self setQuantityLabel:nil];
    [self setScrollView:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}

@end

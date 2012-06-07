//
//  MoviePhotoViewController.m
//  MovieTask
//
//  Created by Omer Janjua on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//this controller displays the selected album art in full screen mode. 

#import "MoviePhotoViewController.h"

@interface MoviePhotoViewController ()

@end

@implementation MoviePhotoViewController
@synthesize movie = _movie;
@synthesize imageView = _imageView;

-(void)loadView
{
    self.title = @"Album Art";
    
    self.imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor blackColor];
    self.view = self.imageView;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.imageView.image = self.movie.identifier;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end

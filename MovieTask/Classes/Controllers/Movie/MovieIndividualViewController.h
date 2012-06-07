//
//  MovieIndividualViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"
#import "MovieDeleteDelegate.h"

@interface MovieIndividualViewController : UIViewController <MovieDeleteDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (nonatomic, retain) Movie *movie;
@property (nonatomic, retain) Copy *movieCopy;

-(IBAction)albumArtButtonPressed:(id)sender;

@end

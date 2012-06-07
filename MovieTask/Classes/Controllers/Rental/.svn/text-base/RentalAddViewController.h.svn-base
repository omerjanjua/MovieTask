//
//  RentalAddViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"

@interface RentalAddViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nightsLabel;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *nightsArray;
@property (nonatomic, retain) NSArray *moviesArray;
@property (nonatomic, retain) NSMutableArray *selectedMovies;
@property (nonatomic, retain) NSString *nightString;
@property (nonatomic, retain) Rental *rental;
@property (nonatomic, retain) Copy *movieCopy;
@property (nonatomic, retain) Movie *movie;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, assign) NSInteger nightsIndex;

-(IBAction)nightsButtonPressed:(id)sender;

@end

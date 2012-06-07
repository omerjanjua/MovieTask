//
//  MovieEditViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"
#import "MovieDeleteDelegate.h"

@interface MovieEditViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *castValue;
@property (weak, nonatomic) IBOutlet UITextField *directorValue;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *ratingArray;
@property (nonatomic, retain) Movie *movie;
@property (nonatomic, retain) NSString *rating;
@property (nonatomic, retain) UIImage *picture;
@property (nonatomic, assign) id <MovieDeleteDelegate> deleteDelegate;
@property (nonatomic, assign) NSInteger ratingIndex;

-(IBAction)albumArtButtonPressed:(id)sender;
-(IBAction)ratingButtonPressed:(id)sender;
-(IBAction)deleteButtonPressed:(id)sender;

@end

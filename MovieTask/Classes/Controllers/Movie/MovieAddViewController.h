//
//  MovieAddViewController.h
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"

typedef enum{
    RatingPicker,
    QuantityPicker,
}PickerType;


@interface MovieAddViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *castValue;
@property (weak, nonatomic) IBOutlet UITextField *directorValue;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *ratingArray;
@property (nonatomic, retain) NSArray *quantityArray;
@property (nonatomic, retain) Movie *movie;
@property (nonatomic, retain) Copy *movieCopy; //renamed becasue "copy" is laready used by the framework
@property (nonatomic, assign) PickerType pickerType;
@property (nonatomic, retain) NSString *rating;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) UIImage *picture;
@property (nonatomic, assign) NSInteger ratingIndex;
@property (nonatomic, assign) NSInteger quantityIndex;

-(IBAction)albumArtButtonPressed:(id)sender;
-(IBAction)ratingButtonPressed:(id)sender;
-(IBAction)quantityButtonPressed:(id)sender;

@end

//
//  RentalAddTableCell.m
//  MovieTask
//
//  Created by Omer Janjua on 23/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalAddTableCell.h"

@implementation RentalAddTableCell
@synthesize albumArt = _albumArt;
@synthesize name = _name;
@synthesize state = _state;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

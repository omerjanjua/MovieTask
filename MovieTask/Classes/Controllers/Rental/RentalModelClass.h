//
//  RentalModelClass.h
//  MovieTask
//
//  Created by Omer Janjua on 24/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Additions.h"

@interface RentalModelClass

+(NSArray*)availableCopies :(Movies*)movie;

+(NSArray*)currentMoviesRentedOut :(Movies*)movie;

@end

//
//  Copy+Additions.h
//  MovieTask
//
//  Created by Omer Janjua on 28/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Copy.h"

@interface Copy (Additions)

+(NSArray*)availableCopies :(Movie*)movie;

+(NSArray*)copiesRentedOut :(Movie*)movie;

@end

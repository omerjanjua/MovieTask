//
//  RentalModelClass.m
//  MovieTask
//
//  Created by Omer Janjua on 24/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RentalModelClass.h"
#import "Additions.h"

@implementation RentalModelClass

+(NSArray*)availableCopies :(Movies*)movie
{
  //  NSPredicate *subQuery = [NSPredicate predicateWithFormat:@"SUBQUERY NOT(ANY rental.rented == NO)"];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND %@", movie, subQuery];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND (SUBQUERY(rental, $x, $x.rented==1).@count == 0)", movie];
    
    NSArray *copyArray = [Copy findAllWithPredicate:predicate];
    
    NSLog(@"COPYARRAY:%@", copyArray);
 
    return copyArray;
}

+(NSArray*)currentMoviesRentedOut :(Movies*)movie
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND (SUBQUERY(rental, $x, $x.rented==1).@count == 1)", movie];
    
    NSArray *copyArray = [Copy findAllWithPredicate:predicate];
    
    NSLog(@"COPYARRAY:%@", copyArray);
    
    return copyArray;
}

@end

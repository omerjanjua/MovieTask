//
//  Copy+Additions.m
//  MovieTask
//
//  Created by Omer Janjua on 28/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Copy+Additions.h"

@implementation Copy (Additions)

//to check if the movie has any available copies i start from the movie entity pass the movie object in as a parameter AND also using the rental relationship to check if no movies are rented out.
//once you have result for no movies rented out and you join that with the movie relationship it shows what available copies are available for that specific movie. 
+(NSArray*)availableCopies :(Movie*)movie
{
    //  NSPredicate *subQuery = [NSPredicate predicateWithFormat:@"SUBQUERY NOT(ANY rental.rented == NO)"];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND %@", movie, subQuery];
    
    //    Movies *movie = [[Movies findByAttribute:@"name" withValue:@"a"]lastObject];
    //    NSArray *array =  [Rental availableCopies:movie];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND (SUBQUERY(rental, $x, $x.rented==1).@count == 0)", movie];
    
    NSArray *copyArray = [Copy findAllWithPredicate:predicate];
        
    return copyArray;
}

//to check if any copies are rented out for that movie i start from the movie entity pass the movie object in as a parameter AND using the rental relationship to check if there are any copies rented out for that movie
+(NSArray*)copiesRentedOut :(Movie*)movie
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(movie == %@) AND (SUBQUERY(rental, $x, $x.rented==1).@count == 1)", movie];
    NSArray *copyArray = [Copy findAllWithPredicate:predicate];
    return copyArray;
}



@end

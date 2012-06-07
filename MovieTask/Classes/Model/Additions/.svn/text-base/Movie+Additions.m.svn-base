//
//  Movies+Additions.m
//  MovieTask
//
//  Created by Omer Janjua on 10/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Movie+Additions.h"
#import "Copy.h"

@implementation Movie (Additions)


+(Movie*)moviesForDictionary:(NSDictionary *)dictionary
{
    Movie * movies = [Movie createEntity];    //fetching the data
    movies.name = [dictionary objectForKey:@"Name"];
    movies.cast = [dictionary objectForKey:@"Cast"];
    movies.director = [dictionary objectForKey:@"Director"];
    movies.rating = [dictionary objectForKey:@"Rating"];
    movies.identifier = [UIImage imageNamed:[dictionary objectForKey:@"Art"]];

    //this retrieves the value of the copy key and runs it that many times creating new unique copy numbers 
    //then assigning them to my copy id and my movie relationship so you know what movie the copy is being generated for. 
    for (int i=0; i<[[dictionary objectForKey:@"Copy"] intValue]; i++) 
    {
        Copy * copy = [Copy createEntity];
        copy.identifier = [self newCopyNumber];
        copy.movie = movies;
    }
    
    return movies;
}

//same as generating the new account number 
+(NSString *)newCopyNumber
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString* uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    CFRelease(uuid);
    
    return uuidString;
}

//this method returns a nsarray which displays if a movie has copies 
//it starts with the movie entity and using the copy relationship does a count onit to see if its not 0
+(NSArray*)moviesHasCopies
{    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"copies.@count!=0"];
    
    NSArray *movieArray = [Movie findAllWithPredicate:predicate];
        
    return movieArray;
}

//to check for available movies i start with the movie entity and using the copies relationship do a subquery on my rental relationship to see weather the rented attribute is == 1
//then i do a count on this subquery to check if it == 0
//then i do a count on the entire query to check if its > 0
+(NSArray*)availableMovies
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(copies, $c, SUBQUERY($c.rental, $x, $x.rented==1).@count==0).@count > 0"];
    
    NSArray *movieArray = [Movie findAllWithPredicate:predicate];
            
    return movieArray;
}

//to check for movies rented out i use the copies relationship and ran a subquery on my rental relationship to check if the rented attribute is ==1 AND also check using the customer relationship by passing in the Customer object as a parameter, so i know the movies that i am check for are for a specific customer 
//then i do a count to check on the subqery and the full query weather its > 0. 
+(NSArray*)moviesRentedOut:(Customer*)customer  //show available movies based on that customer
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(copies, $c, SUBQUERY($c.rental, $x, $x.rented==1 AND $x.customer == %@).@count > 0).@count > 0", customer];
    
    NSArray *movieArray = [Movie findAllWithPredicate:predicate];
        
    return movieArray;
    //delete this instead being used in the customer class
}

//to delete a movie i used a query to check if the movie has no copies left in stock. 
+(NSArray*)moviesWithNoCopies //use for the delete query
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"copies.@count == 0"];
    
    NSArray *movieArray = [Movie findAllWithPredicate:predicate];
        
    return movieArray;
}

@end

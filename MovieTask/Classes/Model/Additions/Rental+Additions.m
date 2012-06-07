//
//  Rental+Additions.m
//  MovieTask
//
//  Created by Omer Janjua on 25/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rental+Additions.h"

@implementation Rental (Additions)

//to calculate the due date i got the value from the rented date and added it to the number of nights the user chose. 
//the calculation is 60seconds*60minutes*24hours*nights
-(NSString*)dueDateString
{    
    NSDate *rentedDate = self.rentedDate;
    NSInteger nights = [self.nights integerValue];
    NSDate *newdate = [rentedDate dateByAddingTimeInterval:60*60*24*nights];

    
    NSDateFormatter *date2 = [[NSDateFormatter alloc] init];
    [date2 setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [date2 stringFromDate:newdate];
    
    return stringFromDate;
}

//to calculate the rental price its just number of nights the customer wants the movie renting out for multiply by 3. 
-(NSString*)rentalPrice
{
    NSInteger nights = [self.nights integerValue];
    NSInteger calculated = (nights * 3) ;
    NSString *rentalPrice = [NSString stringWithFormat:@"£ %d", calculated];
    return rentalPrice;
}

//to check if the customer has any rentals rented out i check if the rented entity is == 1 AND use the customer relationship by passing in the customer object to check the rental i am checking for is for that customer. 
+(NSArray*)rentalsForCustomer:(Customer*)customer
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rented == 1 AND customer == %@", customer];
    
    NSArray *movieArray = [Rental findAllWithPredicate:predicate];
    
    NSLog(@"rentalsForCustomer:%@", movieArray);
    
    return movieArray;
}

@end

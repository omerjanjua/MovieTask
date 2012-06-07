//
//  Customer+Additions.m
//  MovieTask
//
//  Created by Omer Janjua on 10/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Customer+Additions.h"

@implementation Customer (Additions)

//for each value in my key this method retrieves the value from the json file 
+(Customer*)customerForDictionary:(NSDictionary*)dictionary
{
    Customer *customer = [Customer createEntity];   //fetching
    customer.accountNo = [dictionary objectForKey:@"Account No"];
    customer.name = [dictionary objectForKey:@"Name"];
    customer.address = [dictionary objectForKey:@"Address"];
    customer.postcode = [dictionary objectForKey:@"Postcode"];
    customer.number = [dictionary objectForKey:@"Phone Number"];
    customer.state = [dictionary objectForKey:@"State"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormat dateFromString:[dictionary objectForKey:@"Dob"]];
    customer.dob = dateFromString;
    
    return customer;
}

//when a new account is created this methis auto generates a unique identifier as a account number 
//the method returns a string type
+(NSString *)newAccountNumber
{
    //create a new uuid which i own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    //create a cfstringref that i own
    //used bridge transfer because i am using arc
    NSString* uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    //transfer hte ownership of the string 
    CFRelease(uuid);
    
    return uuidString;
    
}

//this methis returns an array of all customers with the state attribute set to 1
//so only open accounts are returned in the array
+(NSArray*)openAccounts
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"state == 1"];
    
    NSArray *accountsArray = [Customer findAllWithPredicate:predicate];
    
    NSLog(@"%@", accountsArray);
    
    return accountsArray;
}

@end

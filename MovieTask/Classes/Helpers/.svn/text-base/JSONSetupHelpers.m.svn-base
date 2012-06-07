//
//  JSONSetupHelpers.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONSetupHelpers.h"
#import "Additions.h"
#import "SettingsManager.h"

@implementation JSONSetupHelpers

+(BOOL)performFirstTimeSetup
{
    BOOL isFirstTime = [SettingsManager isFirstTime];
    
    if (isFirstTime) 
    {
        [JSONSetupHelpers importInitialCustomer];
        [JSONSetupHelpers importInitialMovies];
    }
    [SettingsManager setFirstTimeComplete];
    
    return isFirstTime;
}

//import the initial customer json file data
+(void)importInitialCustomer
{
    NSString *customerPath = [[NSBundle mainBundle] pathForResource:@"Customer" ofType:@"json"];
    NSData *customerData = [NSData dataWithContentsOfFile:customerPath];
    NSArray *customerArray = [customerData objectFromJSONData];
    
    for (NSDictionary *customerDictionary in customerArray) 
    {
        [Customer customerForDictionary:customerDictionary];
    }
    [[NSManagedObjectContext contextForCurrentThread] save];
}

//import the initial movies json file data
+(void)importInitialMovies
{
    NSString *moviesPath = [[NSBundle mainBundle] pathForResource:@"Movies" ofType:@"json"];
    NSData *moviesData = [NSData dataWithContentsOfFile:moviesPath];
    NSArray *moviesArray = [moviesData objectFromJSONData];
    
    for (NSDictionary *moviesDictionary in moviesArray) 
    {
        [Movie moviesForDictionary:moviesDictionary];
    }
    [[NSManagedObjectContext contextForCurrentThread] save];
}

@end

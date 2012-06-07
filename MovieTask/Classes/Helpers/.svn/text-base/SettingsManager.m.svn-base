//
//  SettingsManager.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager

#define FIRSTSTARTKEY @"FIRSTSTART"

//for the first time the app is ran it is given a key
+(void)setFirstTimeComplete
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey: FIRSTSTARTKEY];
}

//this checks weather the key has already been created or not. 
+(BOOL)isFirstTime
{
    NSNumber *firstStartNumber = [[NSUserDefaults standardUserDefaults] objectForKey: FIRSTSTARTKEY];
    BOOL isFirstStart = ![firstStartNumber boolValue];
    return isFirstStart;
}

@end

//
//  CustomerModelClass.m
//  MovieTask
//
//  Created by Omer Janjua on 14/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerModelClass.h"

@implementation CustomerModelClass

+(NSString *)newAccountNumber
{
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString* uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);

    CFRelease(uuid);
    
    return uuidString;
    
}

-(void)openAccounts
{
    
}

@end

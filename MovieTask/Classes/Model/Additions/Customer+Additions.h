//
//  Customer+Additions.h
//  MovieTask
//
//  Created by Omer Janjua on 10/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@interface Customer (Additions)

+(Customer*)customerForDictionary:(NSDictionary*)dictionary;

+(NSString *)newAccountNumber;

+(NSArray*)openAccounts;

@end

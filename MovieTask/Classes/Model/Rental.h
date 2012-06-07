//
//  Rental.h
//  MovieTask
//
//  Created by Omer Janjua on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Copy, Customer;

@interface Rental : NSManagedObject

@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * nights;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSNumber * rented;
@property (nonatomic, retain) NSDate * rentedDate;
@property (nonatomic, retain) NSDate * returnedDate;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) Copy *movieCopy;

@end

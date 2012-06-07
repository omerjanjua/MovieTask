//
//  Customer.h
//  MovieTask
//
//  Created by Omer Janjua on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rental;

@interface Customer : NSManagedObject

@property (nonatomic, retain) NSString * accountNo;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * dob;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * postcode;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSSet *rental;
@end

@interface Customer (CoreDataGeneratedAccessors)

- (void)addRentalObject:(Rental *)value;
- (void)removeRentalObject:(Rental *)value;
- (void)addRental:(NSSet *)values;
- (void)removeRental:(NSSet *)values;

@end

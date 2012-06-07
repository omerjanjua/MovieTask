//
//  Copy.h
//  MovieTask
//
//  Created by Omer Janjua on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Movie, Rental;

@interface Copy : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) Movie *movie;
@property (nonatomic, retain) NSSet *rental;
@end

@interface Copy (CoreDataGeneratedAccessors)

- (void)addRentalObject:(Rental *)value;
- (void)removeRentalObject:(Rental *)value;
- (void)addRental:(NSSet *)values;
- (void)removeRental:(NSSet *)values;

@end

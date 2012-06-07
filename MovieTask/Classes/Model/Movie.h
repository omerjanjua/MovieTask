//
//  Movie.h
//  MovieTask
//
//  Created by Omer Janjua on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Copy;

@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * cast;
@property (nonatomic, retain) NSString * director;
@property (nonatomic, retain) id identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSSet *copies;
@end

@interface Movie (CoreDataGeneratedAccessors)

- (void)addCopiesObject:(Copy *)value;
- (void)removeCopiesObject:(Copy *)value;
- (void)addCopies:(NSSet *)values;
- (void)removeCopies:(NSSet *)values;

@end

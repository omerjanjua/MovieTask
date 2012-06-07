//
//  ImageToDataTransformer.m
//  MovieTask
//
//  Created by Omer Janjua on 21/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//this class is assigned to my identifier attribute which is of type transformable
//The idea behind transformable attributes is that you access an attribute as a non-standard type, but behind the scenes Core Data uses an instance of NSValueTransformer to convert the attribute to and from an instance of NSData. 

#import "ImageToDataTransformer.h"

@implementation ImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}


- (id)transformedValue:(id)value {
    NSData *data = UIImagePNGRepresentation(value);
    return data;
}


- (id)reverseTransformedValue:(id)value {
    return [[UIImage alloc] initWithData:value];
}

@end

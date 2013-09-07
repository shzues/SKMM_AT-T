//
//  MapViewAnnotation.m
//  PetsDirectories
//
//  Created by daniel seet on 3/18/12.
//  Copyright (c) 2012 Tomato Information Technology Services. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation


@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;


@synthesize operationHour = _operationHour;
@synthesize cdDataArrayIndex = _cdDataArrayIndex;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate operationHour:(NSString*)operationHour cdDataArrayIndex:(NSUInteger)cdDataArrayIndex{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        
        _operationHour = [operationHour copy];;
        _cdDataArrayIndex = cdDataArrayIndex;
        
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}


@end
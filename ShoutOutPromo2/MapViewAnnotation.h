//
//  MapViewAnnotation.h
//  PetsDirectories
//
//  Created by daniel seet on 3/18/12.
//  Copyright (c) 2012 Tomato Information Technology Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapViewAnnotation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    
    
    
    NSString *_operationHour;
    NSUInteger _cdDataArrayIndex;
    
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate operationHour:(NSString*)operationHour cdDataArrayIndex:(NSUInteger)cdDataArrayIndex;





@property (copy) NSString *operationHour;

@property NSUInteger cdDataArrayIndex;

@end
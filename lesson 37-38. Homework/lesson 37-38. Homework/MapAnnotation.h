//
//  MapAnnotation.h
//  lesson 37 - MKMapView-p.1
//
//  Created by Admin on 4/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "Student.h"


@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate; //changed from readonly to assing to be able to change coordinate (to drag annotation)
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (strong, nonatomic) Student* student;
@property (assign, nonatomic) NSUInteger kindOfAnnotation;
//@property (assign, nonatomic) CLLocationDistance distanceToMeetingPoint;

//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

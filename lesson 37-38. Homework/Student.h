//
//  SS:Students.h
//  lesson 31 - UITableView Editing pt.1
//
//  Created by Admin on 9/16/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    distanceZone1 = 1,
    distanceZone2 = 2,
    distanceZone3 = 3
}distanceZoneValue;

@interface Student : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSDate * dateOfBirth;
@property (strong, nonatomic) NSString* dateOfBirthAsString;
@property (nonatomic, assign) CLLocationCoordinate2D coordinateStudent;
@property (nonatomic, assign) CLLocationCoordinate2D centerOfCity;
@property (assign, nonatomic) BOOL gender;
@property (assign, nonatomic) CLLocationDistance distanceToMeetingPoint;
@property (assign, nonatomic) NSUInteger distanceZone;

+(Student*) randomStudent;

@end

//
//  SS:Students.m
//  lesson 31 - UITableView Editing pt.1
//
//  Created by Admin on 9/16/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Student.h"

static NSString* firstNamesMale [] = {
    @"Kurt", @"Mark", @"Bill", @"Briane", @"Romeo", @"Bill", @"Ricardo", @"Barak", @"Alexandr", @"Piter", @"Vinny"
};
static NSString* firstNamesFemale [] = {
    @"Jessica", @"Mary", @"Maggy", @"Linda", @"Jouliet", @"Margaret", @"Ann", @"Melany", @"Chloe", @"Amely", @"Alice"
};

static NSString* lastNames [] = {
    @"Cobaine", @"Twen", @"Clinton", @"Molko", @"Kapuciny", @"Tetcher", @"micardo", @"Obama", @"The Great", @"Pen", @"The Pooh"
};
static int namesCount = 11;

@implementation Student

-(void) dealloc {
    NSLog(@"object [%@ %@] of Students.h class is deallocated", self.firstName, self.lastName);
}

+(Student*) randomStudent {

    Student * student =[[Student alloc] init];
    BOOL isMale = arc4random()%2;
    student.gender = isMale;
    if (isMale) {
        student.firstName = firstNamesMale [arc4random () % namesCount];
    } else {
        student.firstName = firstNamesFemale [arc4random () % namesCount];
    }
    student.lastName = lastNames [arc4random () % namesCount];
    
//Random age from 16 to 51 years old
    NSInteger randomYears = arc4random_uniform(33);
    NSInteger randSecondInYear = arc4random_uniform(31557600);
    NSInteger negativeValue = (-1)*((16+randomYears)*31557600+randSecondInYear);
    NSDate *currentDoB = [NSDate dateWithTimeInterval:negativeValue sinceDate:[NSDate date]];
    student.dateOfBirth = currentDoB;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString* stringBD = [formatter stringFromDate:currentDoB];
    student.dateOfBirthAsString=stringBD;

//random location inside some radius 
    CLLocationCoordinate2D centerOfCity;
    centerOfCity.latitude = 50.005833;
    centerOfCity.longitude = 36.229167;
    double radiusForLatitude = 0.09;
    double radiusForLongitude = 0.1;
    CLLocationDegrees latitudeNew = centerOfCity.latitude - radiusForLatitude + (double)(arc4random_uniform(100)/100.f)*2*radiusForLatitude;
    CLLocationDegrees longitudeNew = centerOfCity.longitude - radiusForLongitude + (double)(arc4random_uniform(100)/100.f)*2*radiusForLongitude;
    student.coordinateStudent = CLLocationCoordinate2DMake(latitudeNew, longitudeNew);
    
    return student;
}


@end

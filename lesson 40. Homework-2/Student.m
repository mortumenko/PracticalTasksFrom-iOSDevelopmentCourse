//
//  Student.m
//  lesson 40. Homework-2
//
//  Created by Admin on 2/5/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Student.h"

static NSString* firstNames [] = {
    @"Kurt", @"Mark", @"Bill", @"Briane", @"Romeo",
    @"Margaret", @"Ricardo", @"Barak", @"Alexandr", @"Piter",
    @"Vinny"
};

static NSString* lastNames [] = {
    @"Cobaine", @"Twen", @"Clinton", @"Molko", @"Kapuciny",
    @"Tetcher", @"Micardo", @"Obama", @"The Great", @"Pen",
    @"The Pooh"
};
static int itemsCount = 11;

@implementation Student

-(id) init {
    self = [super init];
    self.firstName = firstNames[arc4random_uniform(itemsCount)];
    self.lastName = lastNames[arc4random_uniform(itemsCount)];
    NSInteger randomYears = arc4random_uniform(33);
    NSInteger randSecondInYear = arc4random_uniform(31557600);
    NSInteger negativeValue = (-1)*((16+randomYears)*31557600+randSecondInYear);
    NSDate *currentDoB = [NSDate dateWithTimeInterval:negativeValue sinceDate:[NSDate date]];
    self.dateOfBirth = currentDoB;
    self.genderIsMale = arc4random()%2;
    self.grade = arc4random()%12;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString* dobString = [formatter stringFromDate:self.dateOfBirth];
    self.dateOfBirthAsString = dobString;
    NSLog(@"student is created: \nFirstN: %@, lastN: %@, gender: %d, date: %@, grade: %d", self.firstName, self.lastName, self.genderIsMale, dobString, self.grade);
    return self;
}

-(void) dealloc {
    NSLog(@"student-object %@ %@ is deallocated", self.firstName, self.lastName);
}

//SS: Студент-level.5
-(void) changeFirstNameThroughIvarToValue:(NSString*) value {
    [self willChangeValueForKey:@"firstName"]; //SS: methods-helpers to help observer to follow ivar-changing
    _firstName=value;
    [self didChangeValueForKey:@"firstName"];
}
-(void) changeLastNameThroughIvarToValue:(NSString*) value {
    [self willChangeValueForKey:@"lastName"];
    _lastName=value;
    [self didChangeValueForKey:@"lastName"];
}
-(void) changeDateOfBirthThroughIvarToValue:(NSDate*) value {
    [self willChangeValueForKey:@"dateOfBirth"];
    _dateOfBirth=value;
    [self didChangeValueForKey:@"dateOfBirth"];
}
-(void) changeGenderIsMaleThroughIvarToValue:(int) value {
    [self willChangeValueForKey:@"genderIsMale"];
    _genderIsMale=value;
    [self didChangeValueForKey:@"genderIsMale"];
}
-(void) changeGradeThroughIvarToValue:(int) value {
    [self willChangeValueForKey:@"grade"];
    _grade=value;
    [self didChangeValueForKey:@"grade"];
}

@end

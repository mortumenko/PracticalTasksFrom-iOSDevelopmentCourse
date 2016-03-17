//
//  Student.m
//  lesson 30. Homework
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
    self.nameSynthesised = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    NSInteger randomYears = arc4random_uniform(33);
    NSInteger randSecondInYear = arc4random_uniform(31557600);
    NSInteger negativeValue = (-1)*((16+randomYears)*31557600+randSecondInYear);
    NSDate *currentDoB = [NSDate dateWithTimeInterval:negativeValue sinceDate:[NSDate date]];
    self.dateOfBirth = currentDoB;
    self.genderIsMale = arc4random()%2;
    self.grade = 2+arc4random()%4;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString* dobString = [formatter stringFromDate:self.dateOfBirth];
    self.dateOfBirthAsString = dobString;
    //NSLog(@"student is created: \nFirstN: %@, lastN: %@, gender: %d, date: %@, grade: %d", self.firstName, self.lastName, self.genderIsMale, dobString, self.grade);
    return self;
}

-(void) dealloc {
    NSLog(@"student-object %@ %@ is deallocated", self.firstName, self.lastName);
}


@end

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
    @"Margaret", @"Ricardo", @"Barak", @"Alexandr"
};

static NSString* lastNames [] = {
    @"Cobaine", @"Twen", @"Clinton", @"Molko", @"Kapuciny",
    @"Tetcher", @"Micardo", @"Obama", @"The Great"
};
static int itemsCount = 9;

@implementation Student

-(id) init {
    self = [super init];
    self.firstName = firstNames[arc4random_uniform(itemsCount)];
    self.lastName = lastNames[arc4random_uniform(itemsCount)];
    //NSLog(@"student [%@ %@] is created", self.lastName, self.firstName);
    return self;
}

-(void) dealloc {
    NSLog(@"student-object [%@ %@] is deallocated", self.lastName, self.firstName);
}

@end

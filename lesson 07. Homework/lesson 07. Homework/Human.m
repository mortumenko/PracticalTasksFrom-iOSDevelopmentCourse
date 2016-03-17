//
//  Human.m
//  lesson 05. Homework
//
//  Created by Admin on 12/28/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Human.h"

@implementation Human

/*
-(instancetype) init {
    self = [super init];
    if (self) {
        NSLog(@"Instance of Human.h is created");
    }
    return self;
}
*/

-(void) moving {
    NSLog(@"I'm moving now");
}

-(void) dealloc {
    NSLog(@"Human-class is dead");
}

@end

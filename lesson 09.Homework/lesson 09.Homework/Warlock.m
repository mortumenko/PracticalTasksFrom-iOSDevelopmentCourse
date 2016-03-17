//
//  Warlock.m
//  lesson 09.Homework
//
//  Created by Admin on 1/28/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Warlock.h"

@implementation Warlock

#pragma mark  - PatientDelegate;

-(void) patientFeelsBad:(Patient*) patient {
    if (patient.temperature > 39.f) {
        NSLog(@"H-r-r-r! My name is %@. %@ must drink this poison", self.warlockName, patient.patientName);
    } else {
        NSLog(@"H-r-r-r! My name is %@. %@ must eat this mushroom", self.warlockName, patient.patientName);
    }
}

@end

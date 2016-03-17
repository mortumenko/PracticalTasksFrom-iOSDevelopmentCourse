//
//  Warlock.h
//  lesson 09.Homework
//
//  Created by Admin on 1/28/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@protocol PatientDelegate;

@interface Warlock : NSObject <PatientDelegate>
@property (strong, nonatomic) NSString * warlockName;


@end

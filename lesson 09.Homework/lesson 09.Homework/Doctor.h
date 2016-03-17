//
//  Doctor.h
//  lesson 09.Homework
//
//  Created by Admin on 1/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Doctor : NSObject <PatientDelegate>
@property (strong, nonatomic) NSString * doctorName;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSMutableDictionary* dictForBodyParts;
@end

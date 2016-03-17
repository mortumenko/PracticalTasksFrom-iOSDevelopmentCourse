//
//  Student.h
//  lesson 30. Homework
//
//  Created by Admin on 2/5/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* nameSynthesised;
@property (strong, nonatomic) NSDate* dateOfBirth;
@property (assign, nonatomic) int genderIsMale;
@property (assign, nonatomic) int grade;
//my additional:
@property (strong, nonatomic) NSString* dateOfBirthAsString;

@end

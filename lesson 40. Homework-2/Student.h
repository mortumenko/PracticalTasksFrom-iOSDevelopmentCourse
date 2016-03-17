//
//  Student.h
//  lesson 40. Homework-2
//
//  Created by Admin on 2/5/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSDate* dateOfBirth;
@property (assign, nonatomic) int genderIsMale;
@property (assign, nonatomic) int grade;
//Мастер-level.7
@property (weak, nonatomic) Student * friend;
//my additional:
@property (strong, nonatomic) NSString* dateOfBirthAsString;

-(void) changeFirstNameThroughIvarToValue:(NSString*) value;
-(void) changeLastNameThroughIvarToValue:(NSString*) value;
-(void) changeDateOfBirthThroughIvarToValue:(NSDate*) value;
-(void) changeGenderIsMaleThroughIvarToValue:(int) value;
-(void) changeGradeThroughIvarToValue:(int) value;

@end

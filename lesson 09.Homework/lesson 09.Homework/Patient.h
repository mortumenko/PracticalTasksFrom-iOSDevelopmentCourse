//
//  Patient.h
//  lesson 09.Homework
//
//  Created by Admin on 1/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PatientDelegate;
/*
typedef enum {
    head,
    hand,
    leg,
    belly,
    finger,
    teeth,
    ear
} partsOfTheBody; */

@interface Patient : NSObject

@property (strong, nonatomic) NSString * patientName;
@property (assign, nonatomic) double temperature;
@property (assign, nonatomic) double phLevel;
@property (assign, nonatomic) BOOL headAche;
@property (weak, nonatomic) id <PatientDelegate> delegate;
@property (strong, nonatomic) NSString * partOfBodyName;

-(void) gotWorse;

@end

@protocol PatientDelegate <NSObject>

-(void) patientFeelsBad:(Patient*) patient;

@end
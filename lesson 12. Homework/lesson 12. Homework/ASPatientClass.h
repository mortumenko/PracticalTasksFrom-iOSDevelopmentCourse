//
//  ASPatientClass.h
//  copied from lesson 09 - Delegates
//
//  Created by Admin on 7/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASPatientClass : NSObject


@property (strong, nonatomic) NSString * patientName;
@property (assign, nonatomic) double temperature;

- (id) initWithBlock:(void(^)(ASPatientClass*, NSString*, double)) block;
- (BOOL) areYouOk;
- (void) takePill;
- (void) makeShot;

@end


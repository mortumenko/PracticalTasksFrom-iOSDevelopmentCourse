//
//  Human.h
//  lesson 05. Homework
//
//  Created by Admin on 12/28/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    male,
    female
} gender;

@interface Human : NSObject
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float heigh;
@property (assign, nonatomic) float weight;
@property gender personsGender;

-(void) moving;

@end

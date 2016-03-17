//
//  SumoMan.h
//  lesson 05. Homework
//
//  Created by Admin on 1/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Human.h"

@interface SumoMan : Human
@property (assign, nonatomic) float radius;
@property (assign, nonatomic) float victoryRate;

-(void) moving;

@end

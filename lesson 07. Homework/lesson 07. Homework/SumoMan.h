//
//  SumoMan.h
//  lesson 05. Homework
//
//  Created by Admin on 1/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Human.h"
#import "runnersProt.h"

@interface SumoMan : Human <runnersProt>

@property (assign, nonatomic) float radius;
@property (assign, nonatomic) float victoryRate;
@property (strong, nonatomic) NSString * runnerName;
@property (assign, nonatomic) float recordVelocity;
@property (strong, nonatomic) NSString *motherLand;



-(void) moving;

#pragma  mark - runnersProt
-(void) run;
-(BOOL) areYouTired;

@end

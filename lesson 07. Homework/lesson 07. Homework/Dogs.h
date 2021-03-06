//
//  Dogs.h
//  lesson 05. Homework
//
//  Created by Admin on 1/4/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Animal.h"
#import "runnersProt.h"


@interface Dogs : Animal <runnersProt>

@property (assign, nonatomic) float recordVelocity;
@property (strong, nonatomic) NSString * runnerName;

-(void) run;

@end

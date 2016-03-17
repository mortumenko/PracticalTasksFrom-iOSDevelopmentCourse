//
//  SumoMan.m
//  lesson 05. Homework
//
//  Created by Admin on 1/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "SumoMan.h"

@implementation SumoMan

-(void) moving {
    NSLog(@"I'm like a wheel. Ho-ho!");
}

#pragma mark - runnersProt
-(void) run {
    NSLog(@"I'm running like a wheel (SumoMan)");
}

-(BOOL) areYouTired {
    int yesNo = arc4random()%2;
    return yesNo;
}
@end

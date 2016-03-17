//
//  Frog.h
//  lesson 05. Homework
//
//  Created by Admin on 1/4/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Animal.h"
#import "jumpersProt.h"

@interface Frog : Animal <jumpersProt>
@property (strong, nonatomic) NSString * jumperName;
@property (assign, nonatomic) float recordLengh;

-(void) jump;
-(void) jumpToHeight;

@end

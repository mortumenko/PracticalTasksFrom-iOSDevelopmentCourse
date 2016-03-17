//
//  Animal.h
//  lesson 05. Homework
//
//  Created by Admin on 1/4/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
@property (strong, nonatomic) NSString* species;
@property (assign, nonatomic) BOOL isMammal;
@property (assign, nonatomic) BOOL isFluffy;

-(void) moving;

@end

//
//  runnersProt.h
//  lesson 07. Homework
//
//  Created by Admin on 8/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol runnersProt <NSObject>
@required
@property (assign, nonatomic) float recordVelocity;
@property (strong, nonatomic) NSString * runnerName;
-(void) run;


@optional
@property (strong, nonatomic) NSString *motherLand;
-(BOOL) areYouTired;

@end

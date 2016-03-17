//
//  SAStudent.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "runnersProt.h"
#import "swimmersProt.h"


//@protocol SAStudentDelegate;

@interface SAStudent : NSObject <runnersProt, swimmersProt>



@property (strong, nonatomic) NSString * studentName;
@property (assign, nonatomic) float recordVelocity;
@property (strong, nonatomic) NSString * runnerName;
@property (strong, nonatomic) NSString * swimmerName;
@property (strong, nonatomic) NSString * motherLand;
@property (assign, nonatomic) float recordDeep;

-(void) run;
-(void) swim;
-(BOOL) isPoolDeeper: (float) deep;


-(void) study;

@end


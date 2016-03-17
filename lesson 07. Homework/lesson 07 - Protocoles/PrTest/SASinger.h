//
//  SASinger.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestProtocol.h"
@interface SASinger : NSObject <TestProtocol>

@property (strong, nonatomic) NSString * patientName;

-(void) singByScream;
-(void) yellingByGrouling;

@end

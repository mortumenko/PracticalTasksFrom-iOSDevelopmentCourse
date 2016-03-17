//
//  SASientist.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
//STEP 2: subscribe all connected classes on this protocol. next step --> *.m-file
#import "TestProtocol.h" //this one

@interface SASientist : NSObject <TestProtocol> // and this one

@property (strong, nonatomic) NSString * patientName;
-(void) invent;


@end

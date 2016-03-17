//
//  SASientist.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
//STEP 2: subscribe all connected classes on this protocol. next step --> *.m-file
#import "swimmersProt.h"

@interface SASientist : NSObject <swimmersProt> // and this one

@property (strong, nonatomic) NSString * sientistName;
@property (strong, nonatomic) NSString * swimmerName;
@property (assign, nonatomic) float recordDeep;

-(void) invent;


@end

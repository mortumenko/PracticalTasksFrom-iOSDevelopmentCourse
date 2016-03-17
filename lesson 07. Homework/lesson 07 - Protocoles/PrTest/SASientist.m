//
//  SASientist.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SASientist.h"

@implementation SASientist
- (void)invent {
    
}

// STEP 3: releasation of all protocol's methods (properties are assigned in engine-class). With pragma mark
#pragma mark - TestProtocol

- (BOOL) areYouOK {
    BOOL ok=arc4random() %2;
    NSLog (@"Is sientist %@ OK? result: %@", self.patientName, ok ? @"YES" : @"NO");
    return ok;
}
- (void) takePill {
    NSLog(@"Sientist %@ has taken a pill", self.patientName);
}
- (void) makeShot {
    NSLog(@"Sientist %@ has taken a shot", self.patientName);
}

//- (NSString *) howIsYourFamily {return @"family of sientist is good"; }
@end

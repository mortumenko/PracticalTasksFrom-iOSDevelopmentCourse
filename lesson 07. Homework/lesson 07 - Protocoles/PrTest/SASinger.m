//
//  SASinger.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SASinger.h"


@implementation SASinger
- (void)singByScream {
    
}
-(void) yellingByGrouling {
    
}

#pragma mark - TestProtocol

- (BOOL) areYouOK {
    BOOL ok=arc4random() %2;
    NSLog (@"Is singer %@ OK? result: %@", self.patientName, ok ? @"YES" : @"NO");
    return ok;
}
- (void) takePill {
    NSLog(@"singer %@ has taken a pill", self.patientName);
}
- (void) makeShot {
    NSLog(@"singer %@ has taken a shot", self.patientName);
}

- (NSString *) howIsYourFamily {
    return @"family of singer is tired of music";
}
@end

//
//  SAStudent.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SAStudent.h"
#import "TestProtocol.h"

@implementation SAStudent
- (void)study {
    
}
#pragma mark - TestProtocol

- (BOOL) areYouOK {
    BOOL ok=arc4random() %2;
    NSLog (@"Is student %@ OK? result: %@", self.patientName, ok ? @"YES" : @"NO");
    return ok;
}
- (void) takePill {
    NSLog(@"student %@ has taken a pill", self.patientName);
}
- (void) makeShot {
    NSLog(@"student %@ has taken a shot", self.patientName);
}

- (NSString *) howIsYourFamily {
    return @"I don't have a family";
}
@end

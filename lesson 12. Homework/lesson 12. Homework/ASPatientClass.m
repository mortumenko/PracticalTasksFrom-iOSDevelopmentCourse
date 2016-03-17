//
//  ASPatientClass.m
//  copied from lesson 09 - Delegates
//
//  Created by Admin on 7/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ASPatientClass.h"
static int count = 0;
@implementation ASPatientClass

//Супермен-level.13
//block allows us to delay execution of some block if we send it with init-command. Also we don't need import all connected classes (AppDelegate), we can send block in any object. Also we can init object in deferent ways, via sending diferent blocks.
//!!! And VERY COOL: we can send some execution algoritm from one class to another only via block, and we can't do the same via method (we can't send method of AppDelegate-class to ASPatientClass !!!
-(id) initWithBlock:(void(^)(ASPatientClass*, NSString*, double)) block {
    self = [super init];
    if (self) {
        NSInteger delay = arc4random_uniform(10)+5;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            block (self, self.patientName, self.temperature);
        });
        count = count+1;
        NSLog(@"patient %d is created. Delay: %lu", count, delay);
    }
    return self;
}

- (BOOL) areYouOk {
    bool feelGoodAnswer = arc4random() %2;
    if (!feelGoodAnswer) {

    }
    return feelGoodAnswer;
}
- (void) takePill {
    NSLog(@"%@ took a pill", self.patientName);
}
- (void) makeShot {
    NSLog(@"%@ made a shot", self.patientName);
}


@end

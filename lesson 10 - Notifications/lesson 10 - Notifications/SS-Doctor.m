//
//  SS-Doctor.m
//  lesson 10 - Notifications
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SS-Doctor.h"
#import "SS-Government.h"

@implementation SS_Doctor

# pragma mark - Initialisation
- (id) init {
    self = [super init];
    if (self) {
        NSNotificationCenter * nc =[NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(salaryGovernNotification:)
                   name:SS_GovernmentSalaryChangedNotification
                 object:nil];
    
        [nc addObserver:self
               selector:@selector(customerBasketGovernNotification:)
                   name:SS_GovernmentConsumerBasketChangedNotification
                 object:nil];
    //SS: Мастер-level
        [nc addObserver:self
               selector:@selector(applicationDidEnterBackgroundNotification:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationDidBecomeActiveNotification:)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationDidFinishLaunchingNotification:)
                   name:UIApplicationDidFinishLaunchingNotification
                 object:nil];
        
    //test
        [nc addObserver:self
               selector:@selector(applicationWillChangeStatusBarOrientation:)
                   name:UIApplicationWillChangeStatusBarOrientationNotification
                 object:nil];
    }
    //NSLog(@"instance SS-Doctor.h init is done");
    return self;
}
// These notifications are sent out after the equivalent delegate message is called
/*
UIKIT_EXTERN NSString *const UIApplicationDidEnterBackgroundNotification       NS_AVAILABLE_IOS(4_0);
UIKIT_EXTERN NSString *const UIApplicationWillEnterForegroundNotification      NS_AVAILABLE_IOS(4_0);
UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;
UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationDidReceiveMemoryWarningNotification;
UIKIT_EXTERN NSString *const UIApplicationWillTerminateNotification;
UIKIT_EXTERN NSString *const UIApplicationSignificantTimeChangeNotification;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarFrameNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarFrameNotification;
*/
-(void) dealloc {
    NSLog(@"%@ is deallocated", self.name);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
# pragma mark - Notifications
//STEP 9: implamentation of observer's method
-(void) salaryGovernNotification: (NSNotification *) notificObj {
    NSNumber * value = [notificObj.userInfo objectForKey:SS_GovernmentSalaryUserInfoKey];
    float salary = [value floatValue];
    if (salary < self.salary) {
        NSLog (@"doctor %@ are NOT happy. privious salary: %.1f", self.name, self.salary);
    } else {
        NSLog (@"doctor %@ are happy. privious salary: %.1f", self.name, self.salary);
    }
    //SS: writing new value to self
    self.salary = salary;
    NSLog(@"%@ SELECTOR method. governmentNotificationAboutSalary userInfo: %@", self.name, notificObj.userInfo);
}
-(void) customerBasketGovernNotification: (NSNotification *) receivedNotification {
    NSLog(@"%@ SELECTOR method. governmentNotificationAboutCustBasket userInfo: %@", self.name, receivedNotification.userInfo);
    NSNumber * newValue = [receivedNotification.userInfo objectForKey:SS_GovernmentConsumerBasketUserInfoKey];
    float basketPrice = [newValue floatValue];
    float ability = self.salary / basketPrice;
    if (ability > 2.f) {
        NSLog(@"%@ said. [k=%.2f] Bad, but I can be patient", self.name, ability);
    } else {
        NSLog(@"%@ said. [k=%.2f] It's unacceptable! Even corruption can't help me to survive!", self.name, ability);
    }
}
-(void) applicationDidEnterBackgroundNotification: (NSNotification*) receivedNotification {
        NSLog(@"%@ said: I'm going to sleep, because I've got 'DidEnterBackgroundNotification'", self.name);
}
-(void) applicationDidBecomeActiveNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I've waked up, because I've got 'applicationDidBecomeActiveNotification'", self.name);
}
//test
-(void) applicationWillChangeStatusBarOrientation: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I've got 'applicationWillChangeStatusBarOrientationNotification'", self.name);
}
-(void) applicationDidFinishLaunchingNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I've got 'applicationDidFinishLaunchingNotification'", self.name);
}

@end

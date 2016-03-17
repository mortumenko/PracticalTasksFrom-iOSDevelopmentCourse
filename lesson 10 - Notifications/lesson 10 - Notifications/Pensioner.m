//
//  Pensioner.m
//  lesson 10 - Notifications
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Pensioner.h"
#import "SS-Government.h"

@implementation Pensioner
-(id) init {
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(notificationAboutPentionLevel:) name:SS_GovernmentPensionLevelChangedNotification object:nil];
        [nc addObserver:self
               selector:@selector(notificationAboutConsumerBasketPrice:) name:SS_GovernmentConsumerBasketChangedNotification object:nil];
        //SS: Мастер-level
        [nc addObserver:self
               selector:@selector(applicationDidEnterBackgroundNotification:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationDidBecomeActiveNotification:)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
    }
    return self;
}

-(void) dealloc {
    NSLog(@"%@ is deallocated", self.name);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
# pragma mark - Notifications
-(void) notificationAboutPentionLevel: (NSNotification*) receivedNotification {
    NSLog(@"%@ know that PentionLevel was changed. Info: %@", self.name, receivedNotification.userInfo);
    NSNumber* value = [receivedNotification.userInfo valueForKey:SS_GovernmentPensionLevelUserInfoKey];
    float newPention = [value floatValue];
    //NSLog(@"isNew %.2f", newPention);
    //load new pension-level in self
    self.pensionLevelCurrent = newPention;
}

-(void) notificationAboutConsumerBasketPrice: (NSNotification*) receivedNotification {
    NSLog(@"%@ know that ConsumerBasketPrice was changed. Info: %@", self.name, receivedNotification.userInfo);
    NSNumber * newValue = [receivedNotification.userInfo objectForKey:SS_GovernmentConsumerBasketUserInfoKey];
    float basketPrice = [newValue floatValue];
    float ability = self.pensionLevelCurrent / basketPrice;
    if (ability > 0.7f) {
        NSLog(@"%@ said. [k=%.2f] Bad, but I can be patient till new election", self.name, ability);
    } else {
        NSLog(@"%@ said. [k=%.2f] It's unacceptable! Want back to USSR!", self.name, ability);
    }
}
-(void) applicationDidEnterBackgroundNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I'm going to sleep, because I've got 'DidEnterBackgroundNotification'", self.name);
}
-(void) applicationDidBecomeActiveNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I've waked up, because I've got 'applicationDidBecomeActiveNotification'", self.name);
}
@end

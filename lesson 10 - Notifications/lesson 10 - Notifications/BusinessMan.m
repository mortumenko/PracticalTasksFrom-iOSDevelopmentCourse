//
//  BusinessMan.m
//  lesson 10 - Notifications
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "BusinessMan.h"
#import "SS-Government.h"

@implementation BusinessMan

-(id) init {
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(notificationAboutTaxLevel:)
                   name:SS_GovernmentTaxLevelChangedNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(notificationAboutConsumerBasketPrice:)
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
        
    }
    self.profitPerMonth = 5000.f;
    self.expectedTaxLevel = 15.f;

    return self;
}
-(void) dealloc {
    NSLog(@"%@ is deallocated", self.name);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark - Notifications

-(void) notificationAboutTaxLevel: (NSNotification*) receivedNotification {
    NSNumber* value = [receivedNotification.userInfo valueForKey:SS_GovernmentTaxLevelUserInfoKey];
    float newTaxLevel = [value floatValue];
    NSLog(@"%@ know that taxLevel was changed. Info: %@. extracted newTaxLevel %.2f", self.name, receivedNotification.userInfo, newTaxLevel);
    if (newTaxLevel < self.expectedTaxLevel) {
        NSLog(@"%@ is glad that taxLevel was decreased to %.2f", self.name, newTaxLevel);
        self.acceptedTaxLevel  = newTaxLevel;
    } else {
        NSLog(@"%@ said that taxLevel was decreased not enough, because expected level is: %.2f", self.name, self.expectedTaxLevel);
    }
}
-(void) notificationAboutConsumerBasketPrice: (NSNotification*) receivedNotification {
    NSLog(@"%@ know that ConsumerBasketPrice was changed. Info: %@", self.name, receivedNotification.userInfo);
    NSNumber * newValue = [receivedNotification.userInfo objectForKey:SS_GovernmentConsumerBasketUserInfoKey];
    float basketPrice = [newValue floatValue];
    float ability = (self.profitPerMonth*(100-self.acceptedTaxLevel)/100) / basketPrice;
    if (ability > 5.f) {
        NSLog(@"%@ said. [k=%.2f] WTF? Ok, but I must increase my prices", self.name, ability);
    } else {
        NSLog(@"%@ said. [k=%.2f] Hey! Do you want to kill business in this country! Do you want a new Maidan?", self.name, ability);
    }
}
-(void) applicationDidEnterBackgroundNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I'm going to sleep, because I've got 'DidEnterBackgroundNotification'", self.name);
}
-(void) applicationDidBecomeActiveNotification: (NSNotification*) receivedNotification {
    NSLog(@"%@ said: I've waked up, because I've got 'applicationDidBecomeActiveNotification'", self.name);
}
@end

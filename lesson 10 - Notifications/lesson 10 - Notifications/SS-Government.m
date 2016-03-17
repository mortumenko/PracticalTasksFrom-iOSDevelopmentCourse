//
//  SS-Government.m
//  lesson 10 - Notifications
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SS-Government.h"

// STEP 3: write text of notifications
NSString * const SS_GovernmentTaxLevelChangedNotification=@"from SS_Government: TaxLevelChangedNotification IsDone";
NSString * const SS_GovernmentSalaryChangedNotification=@"from SS_Government: SalaryChangedNotification IsDone";
NSString * const SS_GovernmentPensionLevelChangedNotification=@"from SS_Government: PensionChangedNotification IsDone";
NSString * const SS_GovernmentConsumerBasketChangedNotification=@"from SS_Government: ConsumerBasketChangedNotification IsDone";

// STEP 5: assigning text for dictionary's keys for using postnotification method
NSString * const SS_GovernmentTaxLevelUserInfoKey=@"SS_GovernmentTaxLevelUserInfoKeyContent";
NSString * const SS_GovernmentSalaryUserInfoKey=@"SS_GovernmentSalaryUserInfoKeyContent";
NSString * const SS_GovernmentPensionLevelUserInfoKey=@"SS_GovernmentPensionLevelUserInfoKeyContent";
NSString * const SS_GovernmentConsumerBasketUserInfoKey=@"SS_GovernmentConsumerBasketUserInfoKeyContent";

@implementation SS_Government

// this stuff is making class-instance and assigning start-properties for it
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taxLevel=15.5f;
        self.salary=1200.0f;
        self.pensionAverLevel=600.0f;
        self.consumerBasket=800.0f;
    }
    return self;
}
// STEP 6: we want to send notification to all subscribers when some parametr is changed. Insert code into the setters
-(void) setTaxLevel:(float)taxLevel {
    _taxLevel=taxLevel;
    NSDictionary * dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel] forKey:SS_GovernmentTaxLevelUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SS_GovernmentTaxLevelChangedNotification
                                                        object:nil
                                                      userInfo:dictionary];
}
-(void) setSalary:(CGFloat)salary {
    _salary=salary;
    NSDictionary * dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary] forKey:SS_GovernmentSalaryUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SS_GovernmentSalaryChangedNotification
                                                        object:nil
                                                      userInfo:dictionary];
}
-(void) setPensionAverLevel:(float)pensionAverLevel{
    _pensionAverLevel=pensionAverLevel;
    NSDictionary * dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pensionAverLevel] forKey:SS_GovernmentPensionLevelUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SS_GovernmentPensionLevelChangedNotification
                                                        object:nil
                                                      userInfo:dictionary];
}
-(void) setConsumerBasket:(float)consumerBasket {
    _consumerBasket=consumerBasket;
    NSDictionary * dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:consumerBasket] forKey:SS_GovernmentConsumerBasketUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SS_GovernmentConsumerBasketChangedNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

@end

//
//  SS-Government.h
//  lesson 10 - Notifications
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

// I know another example about NOTIFICATIONS with only 3 steps whithout all dictionary's stuff. see at lesson 27. Only three steps becouse of realisation of notification's body inside UITextFiled-class - Yes, it is
// STEP 2: declaration of notifications names
extern NSString * const SS_GovernmentTaxLevelChangedNotification;
extern NSString * const SS_GovernmentSalaryChangedNotification;
extern NSString * const SS_GovernmentPensionLevelChangedNotification;
extern NSString * const SS_GovernmentConsumerBasketChangedNotification;

// STEP 4: creating keys for dictionary for using postnotification method
extern NSString * const SS_GovernmentTaxLevelUserInfoKey;
extern NSString * const SS_GovernmentSalaryUserInfoKey;
extern NSString * const SS_GovernmentPensionLevelUserInfoKey;
extern NSString * const SS_GovernmentConsumerBasketUserInfoKey;

@interface SS_Government : NSObject
// @property (assign, nonatomic) CGFLoat taxLevel;
@property (assign, nonatomic) float taxLevel;
@property (assign, nonatomic) CGFloat salary;
@property (assign, nonatomic) float pensionAverLevel;
@property (assign, nonatomic) float consumerBasket;

@end

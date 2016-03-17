//
//  BusinessMan.h
//  lesson 10 - Notifications
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessMan : NSObject
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float expectedTaxLevel;
@property (assign, nonatomic) float acceptedTaxLevel;
@property (assign, nonatomic) float profitPerMonth;

@end

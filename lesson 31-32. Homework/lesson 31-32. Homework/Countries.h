//
//  Countries.h
//  lesson 31-32. Homework
//
//  Created by Admin on 2/11/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Countries : NSObject

@property (strong, nonatomic) NSString* countryName;
@property (assign, nonatomic) int populationAmount;
@property (assign, nonatomic) float democracyRate;
@property (assign, nonatomic) int businessFreedomRate;

@end

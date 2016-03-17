//
//  Countries.m
//  lesson 31-32. Homework
//
//  Created by Admin on 2/11/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Countries.h"

static NSString* namesUpperList [] = {@"Holland", @"Germany", @"Poland",  @"USA", @"Canada",
                                    @"Chech RP", @"Spane", @"Japan", @"France", @"Switzerland"};
static NSString* namesBottomList [] = {@"Ukraine", @"KNDR", @"Egipt", @"Russia", @"Turkey",
                                    @"Mexica", @"China", @"Siria", @"Zimbabve", @"Belorussia"};
static int namesCount = 10;

@implementation Countries

-(id) init {
    self = [super init];
    BOOL isUpper = arc4random()%2;
    int randNumb = arc4random_uniform(100);

    if (isUpper) {
        NSString* rootName = namesUpperList [arc4random_uniform(namesCount)];
        self.countryName = [rootName stringByAppendingFormat:@"-%d", randNumb];
        self.democracyRate = 3+(arc4random()%200)/100.f;
        self.businessFreedomRate = arc4random_uniform(100);
    } else {
        NSString* rootName = namesBottomList [arc4random_uniform(namesCount)];
        self.countryName = [rootName stringByAppendingFormat:@"-%d", randNumb];
        self.democracyRate = (arc4random()%300)/100.f;
        self.businessFreedomRate = 100+arc4random_uniform(100);
    }
    self.populationAmount = arc4random_uniform(50);
    return self;
}

@end

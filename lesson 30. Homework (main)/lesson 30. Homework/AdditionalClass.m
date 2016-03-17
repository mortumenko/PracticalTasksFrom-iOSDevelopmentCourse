//
//  AdditionalClass.m
//  lesson 30. Homework
//
//  Created by Admin on 11/15/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AdditionalClass.h"

@implementation AdditionalClass

-(id) initWithNumber:(NSInteger)objectsNumber {
    self = [super init];
    //NSLog(@"object of AdditionalClass is  created");
    self.colorOfObject = [self randomColor];
    self.nameOfObject = [NSString stringWithFormat:@"object # %ld", (long)objectsNumber];
    //NSLog(@"object's name: %@", self.nameOfObject);
    return self;
}

- (UIColor*)randomColor {
    float redDigit = (float) (arc4random()%100)/100;
    float greenDigit = (float) (arc4random()%100)/100;
    float blueDigit = (float) (arc4random()%100)/100;
    UIColor* currentColor = [UIColor colorWithRed:redDigit green:greenDigit blue:blueDigit alpha:1.f];
    //NSLog(@"color of AdditionalClass.h-instance is RGB(%.3f; %.3f; %.3f)", redDigit,greenDigit,blueDigit);
    return currentColor;
}
-(void) dealloc {
    NSLog(@"object of AdditionalClass is  deallocated");
}

@end

//
//  Patient.m
//  lesson 09.Homework
//
//  Created by Admin on 1/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Patient.h"

@implementation Patient
-(id) init {
    self = [super init];
    self.headAche = (arc4random()%100)%2;
    const NSArray* partsArray = @[@"head", @"hand", @"leg", @"belly", @"finger", @"teeth", @"ear"];
    NSUInteger randPart = arc4random()%7 ;
    self.partOfBodyName = [partsArray objectAtIndex:randPart];
    return self;
}

-(void) gotWorse {
    NSLog(@"\nI'm %@. My health is becoming worse. My temp. is: [%.1f] and I [%@] headache. And I have sick %@", [self patientName], [self temperature], ([self headAche]) ? @"HAVE" : @"DON'T HAVE", self.partOfBodyName);
    [self.delegate patientFeelsBad:self];
}
@end

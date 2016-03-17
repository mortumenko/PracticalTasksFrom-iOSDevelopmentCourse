//
//  Doctor.m
//  lesson 09.Homework
//
//  Created by Admin on 1/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

-(id) init {
    self = [super init];
    /* if it's nessesary to have full report, with null objects
    NSDictionary* tempDict = @{@"head":@"0",
                              @"hand":@"0",
                              @"leg":@"0",
                              @"belly":@"0",
                              @"finger":@"0",
                              @"teeth":@"0",
                              @"ear":@"0"};
    */
//    self.dictForBodyParts = [[NSMutableDictionary alloc] initWithDictionary:tempDict];
    self.dictForBodyParts = [[NSMutableDictionary alloc] init];
    return self;
}
-(void) updateReportForPatient:(Patient*) patient {
    NSNumber *counterForKey = [self.dictForBodyParts objectForKey:patient.partOfBodyName];
    NSInteger nextCountInt = [counterForKey integerValue]+1;
    NSNumber *newCounterForKey = [NSNumber numberWithInteger:nextCountInt];
    [self.dictForBodyParts setObject:newCounterForKey forKey:patient.partOfBodyName];
}

#pragma mark - PatientDelegate
-(void) patientFeelsBad:(Patient*) patient {
    if (patient.temperature > 38.5f) {
        if (patient.headAche) {
            NSLog(@"Doctor said: patient %@ has taken a shot", patient.patientName);
        } else {
        NSLog(@"Doctor said: patient %@ has taken a pill", patient.patientName);
        }
    } else {
        if (patient.headAche) {
            NSLog(@"Doctor said: patient %@ should to have rest", patient.patientName);
        } else {
        NSLog(@"Doctor said: patient %@ is Ok now", patient.patientName);
        }
    }
    [self updateReportForPatient:patient];
}

@end

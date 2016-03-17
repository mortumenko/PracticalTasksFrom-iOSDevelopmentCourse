//
//  AppDelegate.m
//  lesson 12. Homework
//
//  Created by Admin on 2/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "ASPatientClass.h"


@interface AppDelegate ()
@property (strong, nonatomic) NSMutableArray* studentsArray;
@property (strong, nonatomic) NSArray* patientsArray;

//!!! for blocks like property we use ONLY copy-type

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
/*
    //Ученик.1
    //declaration:
    //whatReturns (^name) (what accepts)
    void (^block1)(void);
    //definition (implementation):
    block1 = ^ {
        NSLog(@"block1 is done");
    };
    //invocation
    block1 ();
    
    //Ученик.2
    void (^block2) (NSString*);
    block2 = ^ (NSString* name) {
        NSLog(@"block2 has printed name: %@", name);
    };
    //invocation
    block2 (@"Joe");
    //Ученик.4
    [self methodThatAcceptsBlock:block2 withOneParam:@"Himera"];
    [self methodThatAcceptsEmptyBlock:block1];
    
//SS: just for trying:
    //declaration
    NSString* (^testBlock7)(NSString*, int, double);
    //definition (implementation)
    testBlock7 = ^(NSString* name, int age, double pressure) {
        return [NSString stringWithFormat:@"%@ %d %.2f", name, age, pressure];
    };
    //invocation
    NSString* output = testBlock7 (@"Gritsko", 14, 120.5);
    NSLog(@"testBlock7: %@", output);
 */
    
    
//Студент
    self.studentsArray = [[NSMutableArray alloc] init];
    for (int item=0; item<10; item++) {
        Student* student = [[Student alloc] init];
        [self.studentsArray addObject:student];
    }
    NSLog(@"total number of students: %lu", (unsigned long)[self.studentsArray count]);
    
    //block-declaration:
    NSComparisonResult (^compareThis) (id obj1, id obj2);
    //block-definition:
    compareThis = ^ (id obj1, id obj2) {
        NSComparisonResult result;
        Student* st1 = obj1; //COOL !!!
        Student* st2 = obj2; //COOL !!!
        //NSLog(@"pair is: %@ and %@", st1.lastName, st2.lastName);
        result = [st1.lastName compare:st2.lastName];
        if (result == NSOrderedSame) {
            result = [st1.firstName compare:st2.firstName];
            return result;
        }
        return result;
    };
    //invocation:
    [self.studentsArray sortUsingComparator:compareThis];
    /*
    NSLog(@"-------------Sorted students array:-----------------");
    for (Student* student in self.studentsArray) {
        NSLog(@"%@ %@", student.lastName, student.firstName);
    }
     */
    
    //Мастер-level.11
    void (^treatmentDecision) (id, NSString*, double);
    treatmentDecision = ^ (id patient, NSString* name, double temperature) {
        if (temperature < 37.5) {
            NSLog(@"patient %@ should go home and take a rest. Temperature: %.1f", name, temperature);
        } else if (temperature < 39.2) {
            NSLog(@"patient %@ have to go home and eat meds. Temperature: %.1f", name, temperature);
        } else {
            NSLog(@"patient %@ must be in hospital and take injections. Temperature: %.1f", name, temperature);
        }
    };
    
//Мастер-level.9, Супермен-level.13
    ASPatientClass * patient1 = [[ASPatientClass alloc] initWithBlock:treatmentDecision];
    patient1.patientName = @"Mario";
    patient1.temperature = 39.10f;
    
    ASPatientClass * patient2 = [[ASPatientClass alloc] initWithBlock:treatmentDecision];
    patient2.patientName = @"Kain";
    patient2.temperature = 36.60f;
    
    ASPatientClass * patient3 = [[ASPatientClass alloc] initWithBlock:treatmentDecision];
    patient3.patientName = @"Mark";
    patient3.temperature = 38.10f;
    
    ASPatientClass * patient4 = [[ASPatientClass alloc] initWithBlock:treatmentDecision];
    patient4.patientName = @"Leon";
    patient4.temperature = 40.60f;
    
    self.patientsArray = [[NSArray alloc] initWithObjects:patient1, patient2, patient3, patient4, nil];
    
//Мастер-level.12
    for (ASPatientClass* patient in self.patientsArray) {
        
        [self feelsBadAndMakeBlock:treatmentDecision
                        forPatient:patient
                          withName:patient.patientName
                   withTemperature:patient.temperature];
    }
    
    return YES;
}

#pragma mark - Additional Methods (My)

//Ученик.4
- (void) methodThatAcceptsBlock: (void (^)(NSString*)) block withOneParam: (NSString*) stringParam {
    NSLog(@"included block we be launched now");
    block (stringParam);
}
- (void) methodThatAcceptsEmptyBlock: (void (^) (void)) block {
    NSLog(@"included block we be launched now");
    block ();
}
//Мастер-level.10
//why sometimes we use method to execute block and don't use block directly? Because we can work with incoming parameters before put it in block. And every method (that uses this block) can work with parameters in with own unique algoritm.
-(void) feelsBadAndMakeBlock: (void(^)(ASPatientClass*, NSString*, double)) block forPatient: (ASPatientClass*) patient withName: (NSString*)name withTemperature: (double) temperature {
    double checkedInHospital = temperature*1.02f;
    block (patient, name, checkedInHospital);
}

@end

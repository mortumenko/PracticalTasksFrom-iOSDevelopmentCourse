//
//  AppDelegate.m
//  lesson 09.Homework
//
//  Created by Admin on 1/18/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "Doctor.h"
#import "Warlock.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Patient * patient1 = [[Patient alloc] init];
    patient1.patientName = @"Mario";
    patient1.temperature = 39.1f;
    
    Patient * patient2 = [[Patient alloc] init];
    patient2.patientName = @"Kain";
    patient2.temperature = 36.6f;
    
    Patient * patient3 = [[Patient alloc] init];
    patient3.patientName = @"Mark";
    patient3.temperature = 38.1f;
    
    Patient * patient4 = [[Patient alloc] init];
    patient4.patientName = @"Leon";
    patient4.temperature = 40.6f;
    
    Patient * patient5 = [[Patient alloc] init];
    patient5.patientName = @"Joe";
    patient5.temperature = 36.6f;
    
    Patient * patient6 = [[Patient alloc] init];
    patient6.patientName = @"Kirk";
    patient6.temperature = 40.4f;
    
    Patient * patient7 = [[Patient alloc] init];
    patient7.patientName = @"Jason";
    patient7.temperature = 36.84f;
    
    Patient * patient8 = [[Patient alloc] init];
    patient8.patientName = @"Dexter";
    patient8.temperature = 39.9f;
    
    Doctor * doctor1 = [[Doctor alloc] init];
    doctor1.doctorName = @"Fraid";
    
    Warlock* warlock1 = [[Warlock alloc] init];
    warlock1.warlockName = @"Ktulhu";
    
    Warlock* warlock2 = [[Warlock alloc] init];
    warlock2.warlockName = @"Forester";
    
    patient1.delegate = doctor1;
    patient2.delegate = doctor1;
    patient3.delegate = doctor1;
    patient4.delegate = doctor1;
    patient5.delegate = doctor1;
    patient6.delegate = doctor1;
    patient7.delegate = warlock1;
    patient8.delegate = warlock2;

    
    NSArray* patientsArray = [[NSArray alloc] initWithObjects:patient1, patient2, patient3, patient4, patient5, patient6, patient7, patient8, nil];
    for (id patient in patientsArray) {
        [patient gotWorse];
        //direct calling doesn't work. And it's normal. You have to call delegate-methods inside implementation another methods inside DELEGATOR (like in one row above)
        //[patient patientFeelsBad:patient];
    }
    NSLog(@"parts of Body report:\n%@", doctor1.dictForBodyParts);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

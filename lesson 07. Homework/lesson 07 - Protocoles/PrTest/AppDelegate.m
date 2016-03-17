//
//  AppDelegate.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"
//STEP 4: import everything, what you need (I don't know why we put this in *.m-file)
#import "TestProtocol.h"
#import "SASientist.h"
#import "SASinger.h"
#import "SAStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // STEP 5: creating all class-objects with their properties
    SASientist * sientist1 = [[SASientist alloc] init];
    SASientist * sientist2 = [[SASientist alloc] init];
    
    SASinger * singer1 = [[SASinger alloc] init];
    SASinger * singer2 = [[SASinger alloc] init];
    SASinger * singer3 = [[SASinger alloc] init];
    
    SAStudent * student1 = [[SAStudent alloc] init];
    SAStudent * student2 = [[SAStudent alloc] init];
    SAStudent * student3 = [[SAStudent alloc] init];
    SAStudent * student4 = [[SAStudent alloc] init];
    
    sientist1.patientName = @"sientist 1 - ALbert";
    sientist2.patientName = @"sientist 2 - Higgs";
    
    singer1.patientName = @"singer 1 - Dexter";
    singer2.patientName = @"singer 2 - Bob";
    singer3.patientName = @"singer 3 - Methew";
    
    student1.patientName = @"student 1 ";
    student2.patientName = @"student 2 ";
    student3.patientName = @"student 3 ";
    student4.patientName = @"student 4 ";
    
    NSArray * patientsArr = [NSArray arrayWithObjects: student4, student2, sientist2, singer2, singer3, singer1, student1, student3, sientist1, nil];
    
    //STEP 6: walking among array's items (class-objects) and saing that object must use the protocol
    // id - becouse item it's object, <TestProtocol> - don't sure, maybe becouse object must have required property *patient.name
    for (id <TestProtocol> patient in patientsArr)
    {
        NSLog(@"Patient Name is - %@", patient.patientName);
        // STEP 7: cheking if object has optional method. Method respondsToSelector:@selector(method-name) , YES if object has this method
        if ([patient respondsToSelector:@selector(howIsYourFamily)]) //method that check if class has a method
        {
            NSLog(@"How is your family? \n Answer: %@", [patient howIsYourFamily]);
             }
        
        //STEP 8: here we define proces's logic (procedure, algorytheme), decide what to do dependence from defferent conditions. But all methods must be done by object's class.
        if (![patient areYouOK]) {
            [patient takePill];
            if (! [patient areYouOK]) {
                [patient makeShot];
            }
        }
        
    }
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

//
//  AppDelegate.m
//  lesson 10 - Notifications
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "SS-Government.h"
#import "SS-Doctor.h"
#import "BusinessMan.h"
#import "Pensioner.h"
#import "PseudoAppDelegate.h"

@interface AppDelegate ()
@property (strong, nonatomic) SS_Government * governmentInst;
@property (strong, nonatomic) NSArray* humans;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // STEP 7: we assign observer (AppDelegate.m in this case) on notification
    NSNotificationCenter * nc =[NSNotificationCenter defaultCenter]; //this is a SINGLE-TONE, Only one object of this class is allowed
    //method for realisation if event is done
    /*
    [nc addObserver:self
           selector:@selector(governmentNotifAboutTaxes:)
               name:SS_GovernmentTaxLevelChangedNotification
             object:nil];
     */
   
    // new (for me) way to create class-instance
    self.governmentInst = [[SS_Government alloc] init];
    
    SS_Doctor * doctor1=[[SS_Doctor alloc] init];
    SS_Doctor * doctor2=[[SS_Doctor alloc] init];
    doctor1.name = @"doctor1";
    doctor2.name = @"doctor2";
    NSLog(@"%@ is ready", doctor1.name);
    
    [doctor1 setSalary:1250.0];
    [doctor2 setSalary:1400.0];
    
//SS: Ученик-level
    BusinessMan* businessMan1 = [[BusinessMan alloc] init];
    businessMan1.name = @"businessMan1";
    businessMan1.acceptedTaxLevel = [self.governmentInst taxLevel];
    
    Pensioner* pensioner1 = [[Pensioner alloc] init];
    pensioner1.name = @"pensioner1";
    pensioner1.pensionLevelCurrent = [self.governmentInst pensionAverLevel];
    
    PseudoAppDelegate* instance1 = [[PseudoAppDelegate alloc] init];
    
    
    // STEP 10: making an altering (event, changing)
    /*
    self.governmentInst.taxLevel = 20.1f;
    self.governmentInst.salary = 1900.0f;
    self.governmentInst.pensionAverLevel = 660.0f;
    self.governmentInst.consumerBasket = 810.5f;
    */
    //SS: add into strong property every-object that we want to keep alive (not dealloc after finishing application:didFinishLaunchingWithOptions:). with help of array of directly to self
    self.humans  = [[NSArray alloc] initWithObjects:doctor1, doctor2, businessMan1, pensioner1, instance1, nil];
    NSLog(@"----> Delegate: didFinishLaunchingWithOptions");
    return YES;
}
 // STEP 8: !!! VERY IMPORTANT !!! we remove observer
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"----> Delegate: applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"----> Delegate: applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"----> Delegate: applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"----> Delegate: applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"----> Delegate: applicationWillTerminate");
}

# pragma mark - Notifications
//STEP 9: implamentation of observer's method
-(void) governmentNotifAboutTaxes: (NSNotification *) notificationObj {
    NSLog(@"AppDelegate's SELECTOR method. governmentNotificationAboutTaxes userInfo: %@", notificationObj.userInfo);
}

@end

//
//  AppDelegate.m
//  lesson 05. Homework
//
//  Created by Admin on 12/28/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "bycycler.h"
#import "runner.h"
#import "swimmer.h"
#import "SumoMan.h"
#import "Animal.h"
#import "bird.h"
#import "Frog.h"
#import "Dogs.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    bycycler * bycycler1 = [[bycycler alloc] init];
    bycycler1.name = @"Bob";
    bycycler1.heigh = 1.85f;
    bycycler1.weight = 85.f;
    bycycler1.personsGender = male;
    
    //NSLog(@"bycycler1 is: %@", (bycycler1.personsSex) ? @"woman" : @"man");

    
    runner * runner1 = [[runner alloc] init];
    runner1.name = @"Mark";
    runner1.heigh = 1.70f;
    runner1.weight = 80.f;
    runner1.personsGender = male;
    
    swimmer * swimmer1 = [[swimmer alloc] init];
    swimmer1.name = @"Skiler";
    swimmer1.heigh = 1.75f;
    swimmer1.weight = 75.f;
    swimmer1.personsGender = female;
    
    SumoMan * SumoMan1 = [[SumoMan alloc] init];
    SumoMan1.name = @"Simamura";
    SumoMan1.heigh = 1.75f;
    SumoMan1.weight = 180.f;
    SumoMan1.personsGender = male;
    SumoMan1.radius = 0.80f;
    SumoMan1.victoryRate = 0.63f;
    
    SumoMan * SumoMan2 = [[SumoMan alloc] init];
    SumoMan2.name = @"Babayota";
    SumoMan2.heigh = 1.75f;
    SumoMan2.weight = 190.f;
    SumoMan2.personsGender = male;
    SumoMan2.radius = 1.1f;
    SumoMan2.victoryRate = 0.74f;
    
    bird * bird1 = [[bird alloc] init];
    bird1.species = @"Eagle";
    bird1.isMammal = NO;
    bird1.isFluffy = YES;
    
    Frog * frog1 = [[Frog alloc] init];
    frog1.species = @"green poisoned frog";
    frog1.isMammal = NO;
    frog1.isFluffy = NO;
    
    Dogs * dog1 = [[Dogs alloc] init];
    dog1.species = @"Husky";
    dog1.isMammal = YES;
    dog1.isFluffy = YES;
    
    NSArray * array = [[NSArray alloc] initWithObjects:bycycler1,runner1, swimmer1, SumoMan1, SumoMan2, bird1, frog1, dog1, nil];
    NSInteger numberOfItems = [array count];
    NSMutableArray *reversedArray = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
    
    for (NSInteger item=(numberOfItems-1); item>=0; item--) {
        [reversedArray addObject:[array objectAtIndex:item]];
    }
    
    
        for (id item in reversedArray) {
                if ([item isKindOfClass:[Human class]]) {
                    NSLog(@"\n******HUMAN******");
                    NSString* sexCurrent = nil;
                    NSLog(@"name is: %@", [item name]);
                    NSLog(@"heigh is: %.3f", [item heigh]);
                    NSLog(@"weight is: %.3f", [item weight]);
                    if (![item personsGender]) {
                        sexCurrent = @"man";
                        } else {
                            sexCurrent = @"woman";
                        }
                    NSLog(@"person's sex is: %@", sexCurrent);
                    //NSLog(@"sex is: %@", (bycycler1.personsSex) ? @"woman" : @"man");

                    if ([item isMemberOfClass:[SumoMan class]]) {
                        NSLog(@"radius is: %.3f", [item radius]);
                        NSLog(@"victoryRate is: %.3f", [item victoryRate]);
                        Human* humanLocalInstance = [[Human alloc] init];
                    //can't realise what to do with this:[item superclass]
                        [humanLocalInstance moving];
                        [item moving];
                    }
            } else {
                NSLog(@"\n******ANIMAL******");
                NSLog(@"species is: %@", [item species]);
                NSLog(@"isMammal = %@", ([item isMammal]) ? @"True" : @"False");
                NSLog(@"isFluffy = %@", ([item isFluffy]) ? @"True" : @"False");
                [item moving];
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

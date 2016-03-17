//
//  AppDelegate.m
//  lesson 07. Homework
//
//  Created by Admin on 8/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "SASientist.h"
#import "SASinger.h"
#import "SAStudent.h"
#import "SumoMan.h"
#import "Frog.h"
#import "Dogs.h"
#import "bird.h"
#import "Driwer.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SASientist * sientist1 = [[SASientist alloc] init];
    SASientist * sientist2 = [[SASientist alloc] init];
    SASinger * singer1 = [[SASinger alloc] init];
    SASinger * singer2 = [[SASinger alloc] init];
    SAStudent * student1 = [[SAStudent alloc] init];
    SumoMan * sumoMan1 = [[SumoMan alloc] init];
    SumoMan * sumoMan2 = [[SumoMan alloc] init];
    Frog * Frog1 = [[Frog alloc] init];
    Dogs * dog1 = [[Dogs alloc] init];
    bird * bird1 = [[bird alloc] init];
    bird * bird2 = [[bird alloc] init];
    Driwer * driwer1 = [[Driwer alloc] init];

    student1.studentName = @"Mark";
    student1.runnerName = student1.studentName;
    student1.recordVelocity = 5.3f;
    student1.recordDeep = 4.0f;
    
    sientist1.sientistName = @"Isaak Newton";
    sientist1.swimmerName = sientist1.sientistName;
    sientist1.recordDeep = 2.66f;
    sientist2.sientistName = @"Max Plank";
    sientist2.swimmerName = sientist2.sientistName;
    sientist2.recordDeep = 2.77f;
    
    
    singer1.singerName = @"Dexter Holland";
    singer1.jumperName = singer1.singerName;
    singer1.recordLengh = 3.25;
    singer2.singerName = @"Kirk Hammet";
    singer2.jumperName = singer2.singerName;
    singer2.recordLengh = 3.45;
    
    sumoMan1.radius = 0.95;
    sumoMan1.victoryRate = 0.55;
    sumoMan1.recordVelocity = 2.1f;
    sumoMan1.name = @"Babayota";
    sumoMan1.runnerName = sumoMan1.name;
    sumoMan2.radius = 0.85;
    sumoMan2.victoryRate = 0.65;
    sumoMan2.recordVelocity = 2.2f;
    sumoMan2.name = @"Simamura";
    sumoMan2.runnerName = sumoMan2.name;
    driwer1.name = @"Veniamin";
    
    Frog1.jumperName = @"Green frog";
    Frog1.recordLengh = 0.04f;
    Frog1.isFluffy = 0;
    Frog1.isMammal = 0;
    dog1.runnerName = @"Jack-fluffy";
    dog1.isMammal = 1;
    dog1.isFluffy = 1;
    dog1.recordVelocity = 2.5f;
    bird1.species = @"Eagle";
    bird2.species = @"Hawk";

   
    
    NSArray * array = [[NSArray alloc] initWithObjects:sientist1, sientist2, singer1, singer2, student1, sumoMan1, sumoMan2,Frog1, dog1, bird1, bird2, driwer1, nil];
    
    //SS: 1-st way for checking if object is assighned on protocol
    for (id object in array) {
        //SS: section for jumpers
        if ([object respondsToSelector:@selector(jump)]) {
            NSLog(@"");
            NSLog(@"\n******** New jumper ********");
            NSLog(@"jumperName is %@", [object jumperName]);
            [object jump];
            [object jumpToHeight];
            NSLog(@"recordLengh is %.3f", [object recordLengh]);
            if ([object isKindOfClass:[Human class]]) {
                NSLog(@"jumper's motherland is %@", [object motherLand]);
                [object howManyMembersInTeam];
            } else if ([object isKindOfClass:[Animal class]]) {
                NSLog(@"isMammal - %@", ([object isMammal]) ? @"YES" : @"NO");
                NSLog(@"isMammal - %@", ([object isFluffy]) ? @"YES" : @"NO");
            }
            //SS: section for runners
        } else if ([object respondsToSelector:@selector(run)]) {
            NSLog(@"");
            NSLog(@"\n******** New runner ********");
            NSLog(@"runnerName is %@", [object runnerName]);
            [object run];
            NSLog(@"recordVelocity is %.3f", [object recordVelocity]);
            if ([object isKindOfClass:[Human class]]) {
                NSLog(@"runner's motherland is %@", [object motherLand]);
                NSLog(@"Am I tired? - %@", ([object areYouTired]) ? @"YES" : @"NO");
            } else if ([object isKindOfClass:[Animal class]]) {
                NSLog(@"isMammal - %@", ([object isMammal]) ? @"YES" : @"NO");
                NSLog(@"isMammal - %@", ([object isFluffy]) ? @"YES" : @"NO");
            }
            //SS: section for swimmers. It WORKS!
        } else if ([object conformsToProtocol:@protocol(swimmersProt)]) {
            NSLog(@"");
            NSLog(@"\n******** New swimmer ********");
            NSLog(@"swimmerName is %@", [object swimmerName]);
            [object swim];
            NSLog(@"recordDeep is %.3f", [object recordDeep]);
            if ([object isKindOfClass:[Human class]]) {
                NSLog(@"runner's motherland is %@", [object motherLand]);
                NSLog(@"Am I tired? - %@", ([object isPoolDeeper:3.75]) ? @"YES" : @"NO");
            }
        } else if ([object isKindOfClass:[Human class]]) {
                NSLog(@"Human object %@ is lazzy", [object name]);
        } else if ([object isKindOfClass:[Animal class]]) {
            NSLog(@"Animal object %@ is lazzy", [object species]);
        }
    }

    /* DOESn't work
    //SS: 2-st way for checking if object is assighned on protocol
    for (id <swimmersProt> objSwimmer in array) {
            //SS: section for swimmers
            NSLog(@"");
            NSLog(@"******** New swimmer ********");
            NSLog(@"swimmerName is %@", [objSwimmer swimmerName]);
            [objSwimmer swim];
            NSLog(@"recordDeep is %.3f", [objSwimmer recordDeep]);
         if ([objSwimmer isKindOfClass:[Human class]]) {
            NSLog(@"runner's motherland is %@", [objSwimmer motherLand]);
            NSLog(@"Am I tired? - %@", ([objSwimmer isPoolDeeper:3.75]) ? @"YES" : @"NO");
         }
    }
    */
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

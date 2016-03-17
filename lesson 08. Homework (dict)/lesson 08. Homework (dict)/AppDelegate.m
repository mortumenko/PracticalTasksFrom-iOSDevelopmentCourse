//
//  AppDelegate.m
//  lesson 08. Homework (dict)
//
//  Created by Admin on 1/15/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
//#import "Keys.h"

static NSString* firstNames [] = {
    @"Kurt", @"Mark", @"Bill", @"Briane", @"Romeo",
    @"Margaret", @"Ricardo", @"Barak", @"Alexandr", @"Piter",
};

static NSString* lastNames [] = {
    @"Cobaine", @"Twen", @"Clinton", @"Molko", @"Kapuciny",
    @"Tetcher", @"Micardo", @"Obama", @"The Great", @"Pen",
};
static NSString* greetings [] = {
    @"Hi! I'm from Germany", @"Hi! I'm from Ukraine", @"Hi! I'm from Poland",
    @"Hi! I'm from Chech-Rep", @"Hi! I'm from China", @"Hi! I'm from Japan",
    @"Hi! I'm from USA", @"Hi! I'm from Malasia", @"Hi! I'm from France", @"Hi! I'm from Spaine",
};
static int itemsCount = 10;


@interface AppDelegate ()
@property (strong, nonatomic) NSMutableArray* studentsArray;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSMutableDictionary* classBook = [[NSMutableDictionary alloc] init];
      
    for (int item=0; item<itemsCount; item++) {
        Student* studentCurrent = [[Student alloc] init];
        studentCurrent.firstName = firstNames [arc4random_uniform(itemsCount)];
        studentCurrent.lastName = lastNames [arc4random_uniform(itemsCount)];
        studentCurrent.greating = greetings [arc4random_uniform(itemsCount)];
        [self.studentsArray addObject:studentCurrent];
        NSString* key = [[studentCurrent.lastName stringByAppendingString:@" "] stringByAppendingString:studentCurrent.firstName];
        [classBook setObject:studentCurrent forKey:key];
        //studentCurrent.keyFromNames = key;
    }
    //SS: task 4.1 from homework
    //NSLog(@"classBook content: %@", classBook);
    //SS: task 4.2 from homework
    for (NSString* keyCurrent in [classBook allKeys]) {
        Student* student = [classBook objectForKey:keyCurrent];
        NSLog(@"[%@ %@] says: %@", student.lastName, student.firstName, student.greating);
    }
    //SS: for task 5. Simple and cool way
    NSArray* allKeysArray = [classBook allKeys];
    allKeysArray = [allKeysArray sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
        }];
    //NSArray* sortedArray
    NSLog(@"\nprinting sorted-by-key:");
    for (id keyCurrent in allKeysArray) {
        Student* student = [classBook objectForKey:keyCurrent];
        NSLog(@"[%@ %@] says: %@", student.lastName, student.firstName, student.greating);
    }
    // SS: for task 5. Too complicated.
    /*
    NSMutableArray* tempArrayForKeyObjects = [[NSMutableArray alloc] init];
    for (NSString* keyName in tempArray) {
        Keys * key = [[Keys alloc] init];
        key.keyNameProp = keyName;
        [tempArrayForKeyObjects addObject:key];
    }
    NSSortDescriptor* descriptorForKey = [[NSSortDescriptor alloc] initWithKey:@"keyNameProp" ascending:YES];
    NSArray* descriptorsArr = @[descriptorForKey];
    [tempArrayForKeyObjects sortUsingDescriptors:descriptorsArr];
    
    NSLog(@"printing sorted by key:");
    for (id keyCurrent in tempArrayForKeyObjects) {
        NSString* keyString = [keyCurrent keyNameProp];
        Student* student = [classBook objectForKey:keyString];
        NSLog(@"[%@] says: %@", keyString, student.greating);
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

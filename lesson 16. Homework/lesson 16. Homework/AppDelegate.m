//
//  AppDelegate.m
//  lesson 16. Homework
//
//  Created by Admin on 1/13/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Student16.h"

static NSString* firstNames [] = {
    @"Kurt", @"Mark", @"Bill", @"Briane", @"Romeo",
    @"Margaret", @"Ricardo", @"Barak", @"Alexandr", @"Piter",
    @"Vinny"
};

static NSString* lastNames [] = {
    @"Cobaine", @"Twen", @"Clinton", @"Molko", @"Kapuciny",
    @"Tetcher", @"Micardo", @"Obama", @"The Great", @"Pen",
    @"The Pooh"
};
static int itemsCount = 11;


@interface AppDelegate ()
@property (strong, nonatomic) Student16* studentForComparation;
@property (strong, nonatomic) NSDate* inspeededTime;
@property (strong, nonatomic) NSDate* nowTime;
@property (strong, nonatomic) NSArray* studentsArray;
@property (strong, nonatomic) NSMutableSet* birthDaysSet;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSMutableArray * mutableArray = [[NSMutableArray alloc] init];
    NSDate *dateNow = [NSDate date];
    self.nowTime=dateNow;
    NSMutableArray* birthDaysArray = [[NSMutableArray alloc] init];

    for (int item=0; item<30; item++) {
        Student16 * currentStudent = [[Student16 alloc] init];
        NSInteger randomYears = arc4random_uniform(33);
        NSInteger randSecondInYear = arc4random_uniform(31557600);
        NSInteger negativeValue = (-1)*((16+randomYears)*31557600+randSecondInYear);
        //must be minimum 504921600
        //must be maximum 1577880000
        NSDate *currentDoB = [NSDate dateWithTimeInterval:negativeValue sinceDate:dateNow];
        currentStudent.dateOfBirth = currentDoB;
        [mutableArray addObject:currentStudent];
        [birthDaysArray addObject:currentStudent.dateOfBirth];
}
    //SS: not based on task, just for testing comparator
    NSArray* sortedBirthdayArray = [birthDaysArray sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];
    NSLog(@"Sorted birthday array: \n%@", sortedBirthdayArray);
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSSortDescriptor* birthDayDescr = [[NSSortDescriptor alloc] initWithKey:@"dateOfBirth" ascending:YES];
    NSArray* descriptors = @[birthDayDescr];
    NSArray* sortedArray = [mutableArray sortedArrayUsingDescriptors:descriptors];
    self.birthDaysSet = [[NSMutableSet alloc] init];
    for (Student16 *studentInstance in sortedArray) {
        studentInstance.firstName = firstNames[arc4random_uniform(itemsCount)];
        studentInstance.lastName = lastNames[arc4random_uniform(itemsCount)];
        NSLog(@"First name: %@, last name: %@, date of birth: %@", studentInstance.firstName, studentInstance.lastName,[formatter stringFromDate:studentInstance.dateOfBirth]);
        NSString* stringBD = [formatter stringFromDate:studentInstance.dateOfBirth];
        studentInstance.dateOfBirthAsString=stringBD;
        //NSLog(@"stringBD %@", stringBD);
        [self.birthDaysSet addObject:stringBD];
    }

    NSLog(@"birthDaysSet has %ld objects", [self.birthDaysSet count]);
    self.studentsArray = [[NSArray alloc] initWithArray:sortedArray];
    //SS: doesn't works
//    [self.studentsArray arrayByAddingObjectsFromArray:sortedArray];
    
    NSLog(@"studentsArray has %ld objects", [self.studentsArray count]);

    
    NSInteger fiftyYearsInSeconds = -1*31557600*50;
    self.inspeededTime = [NSDate dateWithTimeInterval:fiftyYearsInSeconds sinceDate:[NSDate date]];
    //NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.01  target:self selector:@selector(inspeedTimeWithTimer:) userInfo:nil repeats:YES];
    
    
    //SS: task for Master 12
    NSDate * ealistBirthDate = [[sortedArray firstObject] dateOfBirth];
    NSDate * oldestBirthDate = [[sortedArray lastObject] dateOfBirth];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar
                                     components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay
                                     fromDate:ealistBirthDate
                                     toDate:oldestBirthDate
                                     options:0];
    NSLog(@"differance is: %@", components);
    
    
                           
    return YES;
}
// SS: created, but couldn't use this
-(NSComparisonResult) comparitionByDate: (Student16 *)otherPerson {
    return [self.studentForComparation.dateOfBirth compare:otherPerson.dateOfBirth];
}

-(void) inspeedTimeWithTimer: (NSTimer*) timer {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.inspeededTime = [NSDate dateWithTimeInterval:(3600*24) sinceDate:self.inspeededTime];
    NSString* inspeededTimeAsString = [formatter stringFromDate:self.inspeededTime];
    NSLog(@"inspeededTime %@", inspeededTimeAsString);

    if ([self.birthDaysSet containsObject:inspeededTimeAsString]) {
        for (Student16* student in self.studentsArray) {
            if ([student.dateOfBirthAsString isEqualToString:inspeededTimeAsString]) {
                NSLog(@"Happy birthday %@, %@ !!! Date of birthDay is: %@", student.firstName, student.lastName, student.dateOfBirth);
            }
        }
    }
    if ([self.nowTime  compare:self.inspeededTime]==-1) {
        [timer invalidate];
        NSLog(@"timer is stopped");
    }
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

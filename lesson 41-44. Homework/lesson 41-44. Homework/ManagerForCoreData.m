//
//  ManagerForCoreData.m
//  lesson41-CoreDataPart1Basic
//
//  Created by Admin on 3/14/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ManagerForCoreData.h"
#import "UsersMO.h"

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
static NSString* countries [] = {
    @"Germany", @"Ukraine", @"Poland", @"Chech-Rep", @"China",
    @"Japan", @"USA", @"Malasia", @"France", @"Spaine",
    @"Georgia"
};

static int itemsCount = 11;

@implementation ManagerForCoreData

+(ManagerForCoreData*) sharedManager {
    static ManagerForCoreData* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ManagerForCoreData alloc] init];
    });
    return manager;
}

- (void) generateAndOtherActions {
//    [self generateNumberOfUsers:10];
    [self printAllUsersSortedByKey:@"firstName"];
    //manipulation via code
/*
    NSArray* courseArray = [self getObjectsForEntity:@"Courses"];
    CoursesMO* firstCourse = [courseArray objectAtIndex:1];
    CoursesMO* secondCourse = [courseArray objectAtIndex:2];
    //[firstCourse setValue:@"Heating and ventilation" forKey:@"nameOfCourse"];
    NSArray* studentsArray = [self getObjectsForEntity:@"Users"];
    NSInteger count  = [studentsArray count];
    UsersMO* lastStudent = [studentsArray lastObject];
    UsersMO* preLastStudent = [studentsArray objectAtIndex:count-2];
    [lastStudent setCourseToTeach:firstCourse];
    [preLastStudent setCourseToTeach:secondCourse];

    for (int i=0; i<=4; i++) {
        UsersMO* student = [studentsArray objectAtIndex:i];
        if (i < 2) {
            [student addCourseEnroledObject:firstCourse];
        } else {
            [student addCourseEnroledObject:secondCourse];
        }
    }
    [self saveContext];

*/
    
}


#pragma  mark - Creating objects

-(UsersMO*) addRandomUser {
    UsersMO* newUser = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    newUser.firstName = firstNames[arc4random_uniform(itemsCount)];
    newUser.lastName = lastNames[arc4random_uniform(itemsCount)];
    newUser.motherLand = countries [arc4random_uniform(itemsCount)];
    NSString* twoNames = [NSString stringWithFormat:@"%@-%@", newUser.lastName, newUser.firstName];
    NSString* email = [twoNames stringByAppendingString:@"@somemail.com"];
    NSString* purgedEmail = [email stringByReplacingOccurrencesOfString:@" " withString:@""];
    newUser.email = purgedEmail;
    return newUser;
}

- (void) generateNumberOfUsers: (int) number {
    for (int i = 0; i < number; i++) {
        [self addRandomUser];
    }
    [self.managedObjectContext save:nil];
}
-(CoursesMO*) addCourseNamed: (NSString*) name {
    CoursesMO* course = [NSEntityDescription insertNewObjectForEntityForName:@"Courses" inManagedObjectContext:self.managedObjectContext];
    course.nameOfCourse = name;
    return course;
}

-(void) deleteAllObjectForEntityNamed: (NSString*) name {
    NSArray* array = [self getObjectsForEntity:name];
    for (NSManagedObject* object in array) {
        [self.managedObjectContext deleteObject:object];
    }
    [self saveContext];
}

#pragma  mark - Additional methods
- (NSArray*) getObjectsForEntity: (NSString*) entityName {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    [fetchRequest setResultType:NSManagedObjectResultType];
    //FETCH parametrs
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setFetchLimit:30]; //max amount of rows
    [fetchRequest setRelationshipKeyPathsForPrefetching:@[@"courseEnroled"]];
    [fetchRequest setPredicate:[self createPredicate]];
    if ([entityName isEqualToString:@"Users"]) {
        NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
        NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
        [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    }
    NSError* requestError=nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    return resultArray;
}

-(NSInteger) countObjectsForEntity:(NSString *)entityName {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    [fetchRequest setResultType:NSCountResultType]; //result - array with one object. Then we extract NSIteger from this object (type id)
    NSError* requestError=nil;
    NSArray* resultCount = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    NSInteger extracted = [[resultCount objectAtIndex:0] integerValue];
    return extracted;
}

//SS: to sophisticated !!! See description bellow this method. Don't use this now. But it's good example how to use NSCountResultType
-(NSInteger) countStudentsForCourseMO:(CoursesMO *)course {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    [fetchRequest setResultType:NSCountResultType]; //result - array with one object. Then we extract NSIteger from this object (type id)
    NSError* requestError=nil;
      NSPredicate* predicate1 = [NSPredicate predicateWithFormat:@"courseEnroled contains %@", course];
    [fetchRequest setPredicate:predicate1];
    NSArray* resultCount = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    NSInteger extracted = [[resultCount objectAtIndex:0] integerValue];
    return extracted;
}
// To sophisticated!!! We can simple use KVC-operators, like this:
//NSNumber* number = [self.courseForParsing valueForKeyPath:@"studentOfCourse.@count"];


-(NSArray*) getStudentsForCourseMO:(CoursesMO *)course {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    [fetchRequest setResultType:NSManagedObjectResultType]; //result - MOs
    NSError* requestError=nil;
    NSPredicate* predicate1 = [NSPredicate predicateWithFormat:@"courseEnroled contains %@", course];
    [fetchRequest setPredicate:predicate1];
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    return resultArray;
}


//Filtering results
-(NSPredicate*) createPredicate {
    NSPredicate* returnedPredicate;
    //WORKS (use one of):
    //    returnedPredicate = [NSPredicate predicateWithFormat:@"score > 3.0 AND courses.@count < 3"];
    //    returnedPredicate = [NSPredicate predicateWithFormat:@"score > 3.0 AND score < 3.5"];
    //    returnedPredicate = [NSPredicate predicateWithFormat:@"firstName == %@ AND motherLand == %@", @"Ricardo", @"Ukraine"];
    return returnedPredicate;
}

- (void) printAllUsersSortedByKey:(NSString *)key {
    NSArray* array = [self getObjectsForEntity:@"Users"];
    for (UsersMO* user in array) {
        NSLog(@"%@ %@, email: %@. courses: %lu", user.firstName, user.lastName, user.email, (unsigned long)[user.courseEnroled count]);
        if (user.courseEnroled.count !=0) {
            NSLog(@"student enrolled for : ");
            for (CoursesMO* course in user.courseEnroled) {
                NSLog(@"%@", course.nameOfCourse);
            }
        }
    }
    NSLog(@"total number is: %lu", (unsigned long)[array count]);
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "home.lesson_41_44__Homework" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"lesson_41_44__Homework" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"lesson_41_44__Homework.sqlite"];
    NSError *error = nil;
    //NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        /*
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

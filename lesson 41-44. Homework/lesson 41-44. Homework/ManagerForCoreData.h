//
//  ManagerForCoreData.h
//  lesson41-CoreDataPart1Basic
//
//  Created by Admin on 3/14/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoursesMO.h"
@class UsersMO;

@interface ManagerForCoreData : NSObject

@property (strong, nonatomic) NSDictionary* flagNamesForCountries;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


+(ManagerForCoreData*) sharedManager;
-(void) printAllUsersSortedByKey: (NSString*) key;
-(void) generateAndOtherActions;
-(UsersMO*) addRandomUser;
-(NSArray*) getObjectsForEntity: (NSString*) entityName;
-(NSInteger) countObjectsForEntity: (NSString*) entityName;
-(NSArray*) getStudentsForCourseMO:(CoursesMO *)course;

@end

//
//  UsersMO.h
//  lesson 41-44. Homework
//
//  Created by Admin on 3/23/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CoursesMO;

@interface UsersMO : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * motherLand;
@property (nonatomic, retain) NSSet *courseEnroled;
@property (nonatomic, retain) CoursesMO *courseToTeach;
@end

@interface UsersMO (CoreDataGeneratedAccessors)

- (void)addCourseEnroledObject:(CoursesMO *)value;
- (void)removeCourseEnroledObject:(CoursesMO *)value;
- (void)addCourseEnroled:(NSSet *)values;
- (void)removeCourseEnroled:(NSSet *)values;

@end

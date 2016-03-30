//
//  CoursesMO.h
//  lesson 41-44. Homework
//
//  Created by Admin on 3/23/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UsersMO;

@interface CoursesMO : NSManagedObject

@property (nonatomic, retain) NSString * nameOfCourse;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * faculty;
@property (nonatomic, retain) NSSet *studentOfCourse;
@property (nonatomic, retain) UsersMO *teacher;
@end

@interface CoursesMO (CoreDataGeneratedAccessors)

- (void)addStudentOfCourseObject:(UsersMO *)value;
- (void)removeStudentOfCourseObject:(UsersMO *)value;
- (void)addStudentOfCourse:(NSSet *)values;
- (void)removeStudentOfCourse:(NSSet *)values;

@end

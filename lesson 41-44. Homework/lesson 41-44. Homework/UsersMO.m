//
//  UsersMO.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/23/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "UsersMO.h"
#import "CoursesMO.h"


@implementation UsersMO

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic motherLand;
@dynamic courseEnroled;
@dynamic courseToTeach;

-(BOOL) validateForDelete:(NSError *__autoreleasing *)error {
    NSLog(@"UsersMO.h Validate for delete ");
    return YES;
}
/*
-(void) dealloc {
    NSLog(@"------------> user is deallocated");
}

-(BOOL) validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
    *error = [NSError errorWithDomain:@"BAD first name" code:123 userInfo:nil];
    NSLog(@"value for key [%@] is changed", key);
    return YES;
}
*/
@end

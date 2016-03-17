//
//  SAStudent.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestProtocol.h"

//@protocol SAStudentDelegate;

@interface SAStudent : NSObject <TestProtocol>

//@property (weak, nonatomic) id <SAStudentDelegate> delegate;

@property (strong, nonatomic) NSString * patientName;

-(void) study;

@end

/* @protocol SAStudentDelegate <NSObject>

- (void)studen: (SAStudent *) student didDo: (BOOL) done;

@end */
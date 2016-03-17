//
//  AdditionalClass.h
//  lesson 30. Homework
//
//  Created by Admin on 11/15/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdditionalClass : NSObject
@property (strong, nonatomic) NSString* nameOfObject;
@property (strong, nonatomic) UIColor* colorOfObject;

- (UIColor*)randomColor;
- (id) initWithNumber: (NSInteger) objectsNumber;
@end

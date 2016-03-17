//
//  swimmersProt.h
//  lesson 07. Homework
//
//  Created by Admin on 8/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol swimmersProt <NSObject>

@required
@property (strong, nonatomic) NSString * swimmerName;
-(void) swim;

@optional
@property (strong, nonatomic) NSString * motherLand;
@property (assign, nonatomic) float recordDeep;
-(BOOL) isPoolDeeper: (float) deep;


@end

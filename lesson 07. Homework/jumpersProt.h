//
//  jumpersProt.h
//  lesson 07. Homework
//
//  Created by Admin on 8/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol jumpersProt <NSObject>

@required
@property (assign, nonatomic) float recordLengh;
@property (strong, nonatomic) NSString * jumperName;
-(void) jump;
-(void) jumpToHeight;


@optional
@property (strong, nonatomic) NSString *motherLand;
-(int) howManyMembersInTeam;

@end

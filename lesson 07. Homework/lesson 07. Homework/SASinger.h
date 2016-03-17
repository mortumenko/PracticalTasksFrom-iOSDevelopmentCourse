//
//  SASinger.h
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jumpersProt.h"
@interface SASinger : NSObject <jumpersProt>

@property (strong, nonatomic) NSString * singerName;
@property (strong, nonatomic) NSString * jumperName;
@property (assign, nonatomic) float recordLengh;

@property (strong, nonatomic) NSString *motherLand;

-(void) singByScream;
-(void) yellingByGrouling;

-(void) jump;
-(void) jumpToHeight;
-(int) howManyMembersInTeam;




@end

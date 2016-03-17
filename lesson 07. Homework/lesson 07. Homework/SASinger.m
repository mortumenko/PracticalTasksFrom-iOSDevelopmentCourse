//
//  SASinger.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SASinger.h"


@implementation SASinger
- (void)singByScream {
    NSLog(@"I'm singing by scream");
}

-(void) yellingByGrouling {
    NSLog(@"I'm yelling by Grouling");
}
#pragma mark - jumppersProt
-(void) jump {
    NSLog(@"singer %@ is jumping on the scene like a horse", [self jumperName]);
}
-(void) jumpToHeight {
    NSLog(@"singer %@ has jumped toward top", [self jumperName]);
}

-(int) howManyMembersInTeam {
    int number = arc4random()%12;
    return  number;
}

@end

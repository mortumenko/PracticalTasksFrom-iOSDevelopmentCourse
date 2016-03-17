//
//  SAStudent.m
//  PrTest
//
//  Created by Admin on 7/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SAStudent.h"

@implementation SAStudent
- (void)study {
    
}

# pragma mark - swimmersProt

-(void) swim {
    NSLog(@"Student %@ is swimming now", [self swimmerName]);
}

-(BOOL) isPoolDeeper: (float) deep {
    int isDeaper;
    if (self.recordDeep>deep) {
        isDeaper = 0;
    } else {
        isDeaper = 1;
    }
    return isDeaper;
}

# pragma mark - runnersProt
-(void) run {
    NSLog (@"I'm running (student)");
}


@end



//
//  SSFileCell.m
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 12/19/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SSFileCell.h"

@implementation SSFileCell

- (void)awakeFromNib {
    // Initialization code
}

-(id) init {
    self = [super init];
    if (self) {
        NSLog(@"instancetype of SSFileCell is created");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    NSLog(@"instance of SSFileCell-class setSelected");
    // Configure the view for the selected state
}

@end

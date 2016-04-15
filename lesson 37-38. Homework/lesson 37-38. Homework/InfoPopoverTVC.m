//
//  InfoPopoverTVC.m
//  lesson 37-38. Homework
//
//  Created by Admin on 4/6/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "InfoPopoverTVC.h"

@interface InfoPopoverTVC ()

@end

@implementation InfoPopoverTVC

-(instancetype) init {
    self = [super init];
    if (self) {
        NSLog(@"--------> InfoPopoverTVC was created <--------");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.firstNameTF.text = self.studentForParsing.firstName;
    self.lastNameTF.text = self.studentForParsing.lastName;
    self.dateOfBirthTF.text = self.studentForParsing.dateOfBirthAsString;
    NSString* gender = (self.studentForParsing.gender) ? @"Male" : @"Female";
    self.genderTF.text = gender;
    self.addressTF.text = self.valueForAddress;
    if (self.studentForParsing.distanceToMeetingPoint) {
        self.distanceTF.text = [NSString stringWithFormat:@" %.f meters. Zone # %d", self.studentForParsing.distanceToMeetingPoint, self.studentForParsing.distanceZone];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) dealloc {
    NSLog(@"--------> InfoPopoverTVC was deallocated <--------");
}


@end


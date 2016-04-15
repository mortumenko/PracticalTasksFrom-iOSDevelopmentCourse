//
//  InfoPopoverTVC.h
//  lesson 37-38. Homework
//
//  Created by Admin on 4/6/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface InfoPopoverTVC : UITableViewController

@property (strong, nonatomic) Student* studentForParsing;
@property (strong, nonatomic) NSString* valueForAddress;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTF;
@property (weak, nonatomic) IBOutlet UITextField *genderTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *distanceTF;


@end

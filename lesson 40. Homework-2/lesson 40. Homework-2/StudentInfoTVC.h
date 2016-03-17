//
//  StudentInfoTVC.h
//  lesson 40. Homework-2
//
//  Created by Admin on 2/5/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface StudentInfoTVC : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmContr;
@property (weak, nonatomic) IBOutlet UITextField *gradeTFiled;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allTextFileds;
@property (strong, nonatomic) Student * explicitStudent;

- (IBAction)genderChangedAction:(UISegmentedControl *)sender;
- (IBAction)clearAllFileds:(id)sender;


@end

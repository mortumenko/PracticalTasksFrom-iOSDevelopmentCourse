//
//  InitialTVC.h
//  lesson 36. Homework
//
//  Created by Admin on 2/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthOutlet;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;

- (IBAction)actionFocusOnGrade:(UITextField *)sender;

- (IBAction)actionFocusOnBirthDayTextField:(UITextField *)sender;
- (IBAction)actionShowInfo:(id)sender;
@end

//
//  RegistrationFormTVC.h
//  lesson 29. Homework-4
//
//  Created by Admin on 2/4/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationFormTVC : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allTextFields;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabelsForOutput;
@property (weak, nonatomic) IBOutlet UILabel *isReadyLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (assign, nonatomic) BOOL isHasAtSighn;
@property (weak, nonatomic) IBOutlet UISwitch *switchForReady;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmContr;
@property (weak, nonatomic) IBOutlet UISlider *levelSlider;

- (IBAction)isReadyAction:(UISwitch *)sender;
- (IBAction)genderChangedAction:(UISegmentedControl *)sender;
- (IBAction)levelChangedAction:(UISlider *)sender;

- (IBAction)saveAction:(id)sender;
@end

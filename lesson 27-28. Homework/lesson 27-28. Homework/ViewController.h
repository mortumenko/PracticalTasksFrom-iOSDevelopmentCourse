//
//  ViewController.h
//  lesson 27-28. Homework
//
//  Created by Admin on 1/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fisrtNameTField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allTextFileds;
@property (weak, nonatomic) IBOutlet UITextField *tFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *tFieldAge;
@property (weak, nonatomic) IBOutlet UITextField *tFieldPhoneNumber;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (weak, nonatomic) IBOutlet UILabel *labelFistName;
@property (weak, nonatomic) IBOutlet UILabel *labelLastName;
@property (weak, nonatomic) IBOutlet UILabel *LabelLogin;
@property (weak, nonatomic) IBOutlet UILabel *labelPassword;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *LabelPhNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (assign, nonatomic) BOOL isHasAtSighn;


- (IBAction)extractButton:(id)sender;

@end


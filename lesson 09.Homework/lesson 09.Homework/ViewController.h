//
//  ViewController.h
//  lesson 09.Homework
//
//  Created by Admin on 1/28/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
// SS: Succesfull test for using delegate from existing classes from lybrary's <UITextFieldDelegate>
@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textFiled2;
- (IBAction)textField1Action:(id)sender;

@end

//
//  ViewController.m
//  lesson 09.Homework
//
//  Created by Admin on 1/28/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SS: step1
    self.textField1.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//SS: step 2
#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"delegate method textFieldShouldBeginEditing is DONE !!!");
    return YES;
}
-(BOOL) textFieldShouldClear:(UITextField *)textField {
    NSLog(@"delegate method textFieldShouldClear is DONE !!!");
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)textField1Action:(id)sender {
}
@end

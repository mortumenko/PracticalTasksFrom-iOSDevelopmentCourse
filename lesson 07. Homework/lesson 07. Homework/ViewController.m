//
//  ViewController.m
//  lesson 07. Homework
//
//  Created by Admin on 8/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect1 = CGRectMake(20, 30, 50, 50);
    UIView* viewForRect1 = [[UIView alloc] initWithFrame:rect1];
    self.view.backgroundColor = [UIColor yellowColor];

    viewForRect1.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewForRect1];
    
    CGRect rect2 = CGRectMake(20, 130, 50, 50);
    UITextField * testTextField = [[UITextField alloc] initWithFrame:rect2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

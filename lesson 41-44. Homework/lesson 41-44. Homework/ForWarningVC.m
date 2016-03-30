//
//  ForWarningVC.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ForWarningVC.h"

@interface ForWarningVC ()

@end

@implementation ForWarningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    CGRect rectFor = CGRectMake(50, 50, 200, 75);
    UILabel* label1 = [[UILabel alloc] initWithFrame:rectFor];
    label1.text = @"FORBIDDEN ASSIGNING! User can't teach course that he study";
    label1.backgroundColor = [UIColor cyanColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.numberOfLines = 3;
    [self.view addSubview:label1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TabBarVC.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/22/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "TabBarVC.h"
#import "UsersTCV.h"
#import "CoursesTVC.h"
#import "TeachersTVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//Set configure TabBarController programatically
/*
    UsersTCV* vc1 = [[UsersTCV alloc] initWithStyle:UITableViewStyleGrouped];
    CoursesTVC* vc2 = [[CoursesTVC alloc] initWithStyle:UITableViewStyleGrouped];
    TeachersTVC* vc3 = [[TeachersTVC alloc] initWithStyle:UITableViewStyleGrouped];
    [self setViewControllers:@[vc1, vc2, vc3] animated:YES];
    self.selectedIndex = 0;
     self.navigationItem.title = @"table for tab bellow";
 */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate
//DOESN'T work!
/*
- (void)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"-----> didSelectViewController <--------");
    if ([viewController isKindOfClass:[UsersTCV class]]) {
        self.navigationItem.title = @"Users";
    } else if ([viewController isKindOfClass:[CoursesTVC class]]) {
        self.navigationItem.title = @"Courses";
    } else if ([viewController isKindOfClass:[TeachersTVC class]]) {
        self.navigationItem.title = @"Teachers";
    }
}
*/
@end

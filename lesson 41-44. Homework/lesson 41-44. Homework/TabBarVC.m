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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    NSLog(@"MARK #1");
 */

}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated {
    BOOL indicator;
    if (self.navigationItem.leftBarButtonItem.style != UIBarButtonItemStyleDone) {
        indicator = YES;
    } else {
        indicator = NO;
    }
    
    ParentForCoreDataTVC* selectedVC = (ParentForCoreDataTVC*) self.selectedViewController;
    if ([self.selectedViewController isKindOfClass:[TeachersTVC class]]) {
        NSLog(@"-----> TeachersTVC. Deleting is forbidden <--------");
    } else {
        [selectedVC setEditing:indicator animated:animated]; //sending event to class of selected VC (via parent-class)
        UIBarButtonSystemItem item = UIBarButtonSystemItemEdit; //new enum-variable
        //changing the button-style to "done", if current-mode is editing
        if (indicator) {
            item = UIBarButtonSystemItemDone;
        }
        //SS: second (and futher) initialisations (during every key-pressing) of this button. with chosen Item-style. Notice, that if current-mode is "editing", item is already re-assigned in if-operator bellow to DONE-style
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                    target:self
                                                                                    action:@selector(setEditing:animated:)];
        self.navigationItem.leftBarButtonItem = editButton;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Additional

- (IBAction)insertFromStoryboard:(id)sender {
    [self insertNewObject:sender];
}

- (IBAction)editFromStoryboard:(UIBarButtonItem *)sender {
    [self setEditing:nil];
}

-(void) insertNewObject:(id)sender {
    ParentForCoreDataTVC* selectedVC = (ParentForCoreDataTVC*) self.selectedViewController;
    [selectedVC insertNewObject:sender];
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
/*
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    NSLog(@"-----> didEndCustomizingViewControllers <--------");

}*/

@end

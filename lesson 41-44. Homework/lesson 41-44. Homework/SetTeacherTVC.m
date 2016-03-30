//
//  TeacherTVC.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/24/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "SetTeacherTVC.h"
#import "ManagerForCoreData.h"
#import "UsersMO.h"
#import "ForWarningVC.h"

@interface SetTeacherTVC () <UIPopoverControllerDelegate>
@property (strong, nonatomic) NSArray* usersArray;
@property (strong, nonatomic) UIPopoverController* popoverProp;

@end

@implementation SetTeacherTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usersArray = [[ManagerForCoreData sharedManager] getObjectsForEntity:@"Users"];
    self.navigationItem.title = [NSString stringWithFormat:@"%@-course", self.courseForAssigning.nameOfCourse];
    UIBarButtonItem* cleanBB = [[UIBarButtonItem alloc] initWithTitle:@"No teacher"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self action:@selector(purgeTeacher)];
    self.navigationItem.rightBarButtonItem = cleanBB;
    NSLog(@"viewDidLoad for TeacherTVC");
}
- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"view controllers on stack = %lu", (unsigned long)[self.navigationController.viewControllers count]);
    NSLog(@"index on stack  = %lu", (unsigned long)[self.navigationController.viewControllers indexOfObject:self]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.usersArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Change or assign teacher:";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* userCellIdentifier = @"teacherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:userCellIdentifier];
    }
    UsersMO* user = [self.usersArray objectAtIndex:indexPath.row];
    NSString* infoString = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.textLabel.text = infoString;
    if (user.courseToTeach) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"teacher for course: %@", user.courseToTeach.nameOfCourse];
    } else {
        cell.detailTextLabel.text = nil;
    }
    if ([user.courseToTeach isEqual:self.courseForAssigning]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UsersMO* userSelected = [self.usersArray objectAtIndex:indexPath.row];
    
    if (self.courseForAssigning.teacher) {
        UsersMO* previous = self.courseForAssigning.teacher;
        NSUInteger indexRowPrev = [self.usersArray indexOfObject:previous];
        NSIndexPath* iPathPrev = [NSIndexPath indexPathForRow:indexRowPrev inSection:0];
        UITableViewCell* cellPrevious = [tableView cellForRowAtIndexPath:iPathPrev];
        cellPrevious.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell* cellSelected = [tableView cellForRowAtIndexPath:indexPath];
    if ([userSelected.courseEnroled containsObject:self.courseForAssigning]) {
        CGRect cellRect = cellSelected.contentView.frame;
        [self warningMessageFromRect:cellRect];
    } else {
        self.courseForAssigning.teacher = userSelected;
        cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
        [[ManagerForCoreData sharedManager] saveContext];
    }
    
    //UITableViewCellAccessoryNone
    //UITableViewCellAccessoryCheckmark
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
# pragma mark - Additional
//SS: for iPhone IDIOM.
-(void) showVCAsModal:(UIViewController*) receivedVC {
    [self presentViewController:receivedVC
                       animated:YES
                     completion:^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismissViewControllerAnimated:YES completion:nil];
                         });
                     }];
}

-(void) warningMessageFromRect:(CGRect) rect {
    ForWarningVC* vc = [[ForWarningVC alloc] init];
    //SS: Checking if current device iPad or iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //SS: Using different VC for iPad and iPhone
        UIPopoverController* popover1 = [[UIPopoverController alloc] initWithContentViewController:vc];
        [popover1 presentPopoverFromRect:rect
                                  inView:self.view
                permittedArrowDirections:UIPopoverArrowDirectionAny
                                animated:YES];
        popover1.popoverContentSize = CGSizeMake(300, 200);
        popover1.delegate = self;
        self.popoverProp = popover1;
    } else {
        NSLog(@"Idiom: iPhone");
        [self showVCAsModal:vc ];
    }

}
-(void) purgeTeacher {
    if (self.courseForAssigning.teacher) {
        UsersMO* previous = self.courseForAssigning.teacher;
        NSUInteger indexRowPrev = [self.usersArray indexOfObject:previous];
        NSIndexPath* iPathPrev = [NSIndexPath indexPathForRow:indexRowPrev inSection:0];
        UITableViewCell* cellPrevious = [self.tableView cellForRowAtIndexPath:iPathPrev];
        cellPrevious.accessoryType = UITableViewCellAccessoryNone;
        self.courseForAssigning.teacher  = nil;
        [[ManagerForCoreData sharedManager] saveContext];
        NSLog(@"---------------------> Course doesn't have teacher now");
    }
}

# pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popoverProp = nil;
    NSLog(@"popoverControllerDidDismissPopover is done");
}
@end

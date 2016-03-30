//
//  StudentsForEnrolling.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/24/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "SetStudentsTVC.h"
#import "ManagerForCoreData.h"
#import "UsersMO.h"

@interface SetStudentsTVC ()
@property (strong, nonatomic) NSArray* usersArray;

@end

@implementation SetStudentsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usersArray = [[ManagerForCoreData sharedManager] getObjectsForEntity:@"Users"];
    self.navigationItem.title = [NSString stringWithFormat:@"%@-course", self.courseForParsing.nameOfCourse];
    NSLog(@"--------> viewDidLoad for StudentsForEnrolling VC");
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
    return @"Add or remove students:";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* userCellIdentifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:userCellIdentifier];
    }
    UsersMO* user = [self.usersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    if (user.courseToTeach) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"teacher for course: %@", user.courseToTeach.nameOfCourse];
    } else {
        cell.detailTextLabel.text = nil;
    }
    if ([user.courseEnroled containsObject:self.courseForParsing]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UsersMO* studentSelected = [self.usersArray objectAtIndex:indexPath.row];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([studentSelected.courseEnroled containsObject:self.courseForParsing]) {
        [studentSelected removeCourseEnroledObject:self.courseForParsing];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [studentSelected addCourseEnroledObject:self.courseForParsing];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [[ManagerForCoreData sharedManager] saveContext]; //I guess it's not optimal to ask SLQite to save changes after clicking next user. It's better to save all changes in one time durring -dealloc {}. STOP. it will be a lot of code, because two indicator of state: UITableViewCellAccessory and real relationship. So I left save in this method
    
    //UITableViewCellAccessoryNone
    //UITableViewCellAccessoryCheckmark
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

@end

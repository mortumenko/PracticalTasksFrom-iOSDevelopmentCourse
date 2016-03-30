//
//  CourseDetails.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/23/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "CourseDetails.h"
#import "ManagerForCoreData.h"
#import "UsersMO.h"
#import "SetStudentsTVC.h"
#import "SetTeacherTVC.h"
#import "UserDetails.h"


typedef NS_ENUM(NSInteger, infoItems) {
    infoItemName,
    infoItemSubject,
    infoItemFaculty,
    infoItemTeacher
};

@interface CourseDetails () <UITableViewDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) NSArray* studentsInCourse;
@property (assign, nonatomic) BOOL isFirstAppearing;
@property (strong, nonatomic) UIPopoverController* popoverProp;

@end

@implementation CourseDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstAppearing = YES;
    self.navigationItem.title = [NSString stringWithFormat:@"details for course: %@", self.courseForParsing.nameOfCourse];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewStudent:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.studentsInCourse = [[ManagerForCoreData sharedManager] getStudentsForCourseMO:self.courseForParsing];
    NSLog(@"count array: %lu", (unsigned long)[self.studentsInCourse count]);
    
    //SS: can't set textAlignment for footer:
    [[[self.tableView footerViewForSection:1] textLabel] setTextAlignment:NSTextAlignmentCenter];
}
-(void) viewDidAppear:(BOOL)animated {
//without this recreating array contains old data about relationships, and new enrolled student isn't showed in table
//without reloading data changes of student's info (values for keys) are not displayed
        if (self.isFirstAppearing == NO) {
            self.studentsInCourse = [[ManagerForCoreData sharedManager] getStudentsForCourseMO:self.courseForParsing];
            [self.tableView reloadData];
            NSLog(@"------ viewDidAppear again");
        } else {
            self.isFirstAppearing = NO;
            NSLog(@"------ viewDidAppear first time");
        }

    NSLog(@"view controllers on stack = %lu", (unsigned long)[self.navigationController.viewControllers count]);
    NSLog(@"index on stack  = %lu", (unsigned long)[self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Additional methods
//SS: for iPhone IDIOM. isn't used now
-(void) showVCAsModal:(UIViewController*) receivedVC {
    [self presentViewController:receivedVC
                       animated:YES
                     completion:^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismissViewControllerAnimated:YES completion:nil];
                         });
                     }];
}

-(void) addNewStudent:(UIBarButtonItem*) sender {
    SetStudentsTVC* addStudentsVC = [[SetStudentsTVC alloc] initWithStyle:UITableViewStyleGrouped];
    addStudentsVC.courseForParsing = self.courseForParsing;
    //SS: Checking if current device iPad or iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"Idiom: iPad");
        //SS: Using different VC for iPad and iPhone
        UIPopoverController* popover1 = [[UIPopoverController alloc] initWithContentViewController:addStudentsVC];
        
        [popover1 presentPopoverFromBarButtonItem:sender
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
        float superHeight = self.view.frame.size.height;
//        popover1.popoverContentSize = CGSizeMake(300, superHeight-100);
        // or another way:
        addStudentsVC.preferredContentSize = CGSizeMake(300, superHeight-100);
        popover1.delegate = self;
        self.popoverProp = popover1;
    } else {
        NSLog(@"Idiom: iPhone");
        [self.navigationController pushViewController:addStudentsVC animated:YES];
    }
    NSLog(@"---------> ADD NEW STUDENT <------------");
}

#pragma mark - UITableViewDataSource
//delete-ability
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //forbidden for section with general info
    if (indexPath.section == 0) {
        return NO;
    }
    //allowed for section with enrolled students
    return YES;
}
//delete-commit. It's just changing relationships (remove certain Course from relationship "CourseEnroled" in certain student). It's NOT deleting MO.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
// 1 - Delete the row from the data source
        UsersMO* student = [self.studentsInCourse objectAtIndex:indexPath.row];
        //1.1 - change relationships
        [student removeCourseEnroledObject:self.courseForParsing];
        [[ManagerForCoreData sharedManager] saveContext];
        //1.2 - remove object from array, that is datasource fro tableView
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:self.studentsInCourse];
        [tempArray removeObject:student];
        self.studentsInCourse = tempArray;
// 2 - Delete the row from the tableView
        [self.tableView beginUpdates]; //method-helper-1
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates]; //method-helper-2
        [self.tableView reloadData]; //without this reloading counter in footer shows old count (but table shows deletioning of student) 
    }
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return [self.studentsInCourse count];
    }
}
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"General info (editable):";
    } else {
        return @"Enrolled students:";
    }
}
-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 1) {
        NSInteger number = [self.studentsInCourse count];
        NSString* str = [NSString stringWithFormat:@"total number: %lu", (long)number];
        return str;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* courseCellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:courseCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:courseCellIdentifier];
    }
    [self configureCourseCell:cell atIndexPath:indexPath];
    return cell;
}
-(void) configureCourseCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    if (indexPath.section == 0) {
        CoursesMO* course = self.courseForParsing;
        UITextField* textField = [[UITextField alloc] init];

        if (indexPath.row != infoItemTeacher) {
            float cellHeight = cell.contentView.frame.size.height;
            float height = 30;
            float offset = (cellHeight-height)/2;
            
            textField.backgroundColor = [UIColor greenColor];
            textField.frame = CGRectMake(120, offset, 150, height);
            textField.font = [UIFont fontWithName:@"Arial" size:14];
            textField.delegate = self;
            [cell.contentView addSubview:textField];
        }
        
        switch (indexPath.row) {
             case infoItemName:
                cell.contentView.tag = infoItemName;
                textField.text = course.nameOfCourse;
                cell.detailTextLabel.text = @"name of course";
                break;
             case infoItemSubject:
                cell.contentView.tag = infoItemSubject;
                textField.text = course.subject;
                cell.detailTextLabel.text = @"subject";
                break;
             case infoItemFaculty:
                cell.contentView.tag = infoItemFaculty;
                textField.text = course.faculty;
                cell.detailTextLabel.text = @"faculty";
                break;
             case infoItemTeacher:
                cell.detailTextLabel.text = @"teacher";
                if (course.teacher) {
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
                    cell.textLabel.textColor = nil;
                } else {
                    cell.textLabel.text = @"choose the teacher";
                    cell.textLabel.textColor = [UIColor redColor];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
         default:
                break;
         }
        
    } else if (indexPath.section == 1) {
        UsersMO* student = [self.studentsInCourse objectAtIndex:indexPath.row];
        NSString* infoString = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        cell.textLabel.text = infoString;
    }
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger aTag = textField.superview.tag;
    NSString* keyForEditing;
    switch(aTag) {
        case infoItemName:
            keyForEditing = @"nameOfCourse";
            break;
        case infoItemSubject:
            keyForEditing = @"subject";
            break;
        case infoItemFaculty:
            keyForEditing = @"faculty";
            break;
        default:
            return;
    }
    [self.courseForParsing setValue:textField.text forKey:keyForEditing];
    [[ManagerForCoreData sharedManager] saveContext];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        UsersMO* studentSelected = [self.studentsInCourse objectAtIndex:indexPath.row];
        UserDetails* vc = [[UserDetails alloc] initWithStyle:UITableViewStyleGrouped];
        vc.userForParsing = studentSelected;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == infoItemTeacher) {
        SetTeacherTVC* vc = [[SetTeacherTVC alloc] initWithStyle:UITableViewStyleGrouped];
        vc.courseForAssigning = self.courseForParsing;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"remove from course?";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

# pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popoverProp = nil;
    //without this recreating array contains old data about relationships, and new enrolled student isn't showed in table
    self.studentsInCourse = [[ManagerForCoreData sharedManager] getStudentsForCourseMO:self.courseForParsing];
    [self.tableView reloadData];
    NSLog(@"popoverControllerDidDismissPopover is done");
}
@end

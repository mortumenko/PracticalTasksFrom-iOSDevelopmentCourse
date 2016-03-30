//
//  TeachersTVC.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "TeachersTVC.h"
#import "UsersMO.h"
#import "ManagerForCoreData.h"
#import "UserDetails.h"

@interface TeachersTVC ()

@end

@implementation TeachersTVC
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = insets;
    
    self.navigationItem.title = @"All teachers";
    self.navigationItem.rightBarButtonItem.enabled = NO;
//Set tabBarItem for TabBarController programatically
    /*
    UIImage* teachersImage = [UIImage imageNamed:@"Teacher-female-24.png"];
    UITabBarItem* teachersTBI = [[UITabBarItem alloc] initWithTitle:@"Teachers" image:teachersImage tag:2];
    [self setTabBarItem:teachersTBI];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsController
//re-assigning getter
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        [NSFetchedResultsController deleteCacheWithName:@"teachersCache"]; //inserted because without this operation I used to get Fatal error, when I changed course
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseToTeach.faculty" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescriptors = @[firstNameDescriptor, lastNameDescriptor];
    
    //PREDICATE FOR USERS that are TEACHERS
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"courseToTeach != NULL"];
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    
     NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:@"courseToTeach.faculty"
                                                             cacheName:@"teachersCache"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    //[self.tableView reloadData]; //SS: I added it for re-freshing number of rows in footer in section
}


#pragma mark - UITableViewDataSource

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.numberOfSections == 1) {
        return  @"Users list:";
    } else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [NSString stringWithFormat:@"section for [%@]:", sectionInfo.name];
    }
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UsersMO *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"teacher for course: %@", user.courseToTeach.nameOfCourse];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UsersMO* selectedUser = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UserDetails* detailsVC = [[UserDetails alloc] initWithStyle:UITableViewStyleGrouped];
    detailsVC.userForParsing = selectedUser;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
@end

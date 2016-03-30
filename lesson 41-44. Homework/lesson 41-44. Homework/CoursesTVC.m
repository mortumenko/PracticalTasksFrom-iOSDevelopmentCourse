//
//  CoursesTVC.m
//  lesson 41-44. Homework
//
//  Created by Admin on 3/23/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "CoursesTVC.h"
#import "CoursesMO.h"
#import "CourseDetails.h"
#import "ManagerForCoreData.h"

@interface CoursesTVC ()

@end

@implementation CoursesTVC
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"All courses";
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = insets;
    
//Set tabBarItem for TabBarController programatically
    /*
    UIImage* coursesImage = [UIImage imageNamed:@"courses_training.png"];
    UITabBarItem* coursesTBI = [[UITabBarItem alloc] initWithTitle:@"Courses" image:coursesImage tag:1];
    coursesTBI.badgeValue = [NSString stringWithFormat:@"%d", 0];
    [self setTabBarItem:coursesTBI];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    CourseDetails* detailsSetVC = [[CourseDetails alloc] initWithStyle:UITableViewStyleGrouped];
    detailsSetVC.courseForParsing = (CoursesMO*)newManagedObject;
    [self.navigationController pushViewController:detailsSetVC animated:YES];
}

#pragma mark - NSFetchedResultsController

//re-assigning getter
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        [NSFetchedResultsController deleteCacheWithName:@"CoursesCache"]; //inserted because without this operation I used to get Fatal error, when I changed course
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];

    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:@"CoursesCache"];
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
    [self.tableView reloadData]; //SS: I added it for re-freshing number of rows in footer in section
}

#pragma mark - UITableViewDataSource
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  @"Courses list:";
}

//SS: using method with correct type of NSCountResultType

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSInteger count = [[ManagerForCoreData sharedManager] countObjectsForEntity:@"Courses"];
    return [NSString stringWithFormat:@"total number of courses: %lu", (long)count];
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CoursesMO *courseForCell = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSNumber* count = [courseForCell valueForKeyPath:@"studentOfCourse.@count"];
    cell.textLabel.text = courseForCell.nameOfCourse;
    cell.detailTextLabel.font  = [UIFont fontWithName:@"Arial" size:14];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"number of students: %@", count];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CoursesMO* courseSelected = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CourseDetails* detailChangeVC = [[CourseDetails alloc] initWithStyle:UITableViewStyleGrouped];
    detailChangeVC.courseForParsing = courseSelected;
    [self.navigationController pushViewController:detailChangeVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
@end

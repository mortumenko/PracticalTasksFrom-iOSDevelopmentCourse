//
//  UsersTCV.m
//  lesson41-44 Homework
//
//  Created by Admin on 3/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "UsersTCV.h"
#import "UsersMO.h"
#import "UserDetails.h"
#import "ManagerForCoreData.h"

@interface UsersTCV ()
@end

@implementation UsersTCV
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"All users";
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = insets;
//Set tabBarItem for TabBarController programatically
    /*
    UIImage* usersImage = [UIImage imageNamed:@"group_forum.png"];
    UITabBarItem* usersTBI = [[UITabBarItem alloc] initWithTitle:@"Users" image:usersImage tag:0];
    [self setTabBarItem: usersTBI];
     */
}

- (void) viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
    NSLog(@"viewDidAppear");
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
    UserDetails* detailsVC = [[UserDetails alloc] initWithStyle:UITableViewStyleGrouped];
    
    detailsVC.userForParsing = (UsersMO*) newManagedObject;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - NSFetchedResultsController

//re-assigning getter
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        [NSFetchedResultsController deleteCacheWithName:@"usersCache"]; //inserted because without this operation I used to get Fatal error, when I changed course
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"motherLand" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescriptors = @[firstNameDescriptor, lastNameDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    
//SS: Tried using sectionNameKeyPath:@"someKeyPathForGrouping". KeyPath must be assigned like firstNameDescriptor. But it doesn't work for key-path from one-to-many relationships. And th
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:@"motherLand"
                                                             cacheName:@"usersCache"];
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
    if (tableView.numberOfSections == 1) {
        return  @"Users list:";
    } else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [NSString stringWithFormat:@"section for [%@]:", sectionInfo.name];
    }
}

//SS: using method with correct type of NSCountResultType
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    NSInteger count = [[ManagerForCoreData sharedManager] countObjectsForEntity:@"Users"];
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [NSString stringWithFormat:@"total number of users: %lu", (unsigned long)sectionInfo.numberOfObjects];
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UsersMO *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    if (user.courseToTeach) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"teacher for course: %@", user.courseToTeach.nameOfCourse];
    } else {
        cell.detailTextLabel.text = nil;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UsersMO* selectedUser = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UserDetails* detailsVC = [[UserDetails alloc] initWithStyle:UITableViewStyleGrouped];
    detailsVC.userForParsing = selectedUser;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}


@end

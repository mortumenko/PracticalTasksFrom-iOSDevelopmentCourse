//
//  ParentForCoreDataTVC.h
//  lesson41-CoreDataPart1Basic
//
//  Created by Admin on 3/15/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

//@class DetailViewController;

@interface ParentForCoreDataTVC : UITableViewController <NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void) insertNewObject:(id)sender;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

@end

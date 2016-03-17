//
//  SSDirectoryTableViewController.m
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SSDirectoryTableViewController.h"
#import "SSFileCell.h"
static int newFolderCount = 0;

@interface SSDirectoryTableViewController ()
@property (strong, nonatomic) NSString* selectedPath;

@end

@implementation SSDirectoryTableViewController
//SS: most comments for all methods were left at progect lesson 33 - UITableViewNavigation p.1


-(id) initWithFolderPath:(NSString*) path {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.pathProp = path;
    }
    return self;
}
-(void) setPathProp:(NSString *)pathProp {
    _pathProp = pathProp;
    NSError* error = nil;
    self.contentsArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.pathProp
                                                                             error:&error];
    if (error) {
        NSLog(@"ERROR IS: %@", [error localizedDescription]);
    }
    //Студент-level.3
    self.contentsArray = [self sortedArrayByCertainLogicFromArray:self.contentsArray];
    
    //Студент-level.4
    NSMutableArray* tempArray3 = [[NSMutableArray alloc] initWithArray:self.contentsArray];
    for (id item in self.contentsArray) {
        //search hidden files
        if ([item hasPrefix:@"."]) {
            [tempArray3 removeObject:item];
        }
    }
    self.contentsArray = tempArray3;
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [self.pathProp lastPathComponent];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.pathProp) {
//ASSIGN PATH HERE
        NSLog(@"MARK 1-st loading");
        self.pathProp = @"/Users/admin/Documents";
//        self.pathProp = @"/Volumes/VMware Shared Folders/shared with Ubuntu/lesson about NSFileManager";
    }
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem* addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(addFolderAction:)];
    self.navigationItem.leftBarButtonItem = addBarButton;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    [[NSFileManager defaultManager] setDelegate:self];
}
-(void) viewDidAppear:(BOOL)animated {
    newFolderCount = 0;
}

-(void) dealloc {
    NSLog(@"controller with the path '%@' has been deallocated", self.pathProp);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Wow, wow, HASH! memory is about to be overfilled");
}

-(BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath {
    NSString* objectPath = [self pathForObjectAtIndexPath:indexPath];
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:objectPath isDirectory:&isDirectory];
    return isDirectory;
}
#pragma mark - Actions
-(void)backToRootAction: (UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)actionInfoCell:(id)sender {
    NSLog(@"actionInfoCell is done");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //SS: names for Identifier taken from "utilities bar" -> attributes inspector
    static NSString* folderIdentifier=@"FolderCellIdentifier";
    static NSString* fileIdentifier=@"FileCellIdentifier";
    NSString* fileName = [self.contentsArray objectAtIndex:indexPath.row]; //SS: name of file in parsed directory
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        //SS: instance of SSFileCell-class. But we can't set up UITableViewCellStyle here and use some UIOutlets like property, because cell isn't initiliased via code, but via storyboard
        //But we can't use some UIOutlets like property, because cell with identifier @"folderIdentifier" has one of system-style. If you want to use objects and Outlets - choose style "custom" for this cell (like in "else" case bellow)
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
        cell.textLabel.text = fileName;
        unsigned long folderSize = [self folderSizeForPath:[self pathForObjectAtIndexPath:indexPath]];
        float kBFolderSize = folderSize/1024.f;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f kB", kBFolderSize];
        return cell;
    } else {
        NSString* path = [self.pathProp stringByAppendingPathComponent:fileName];
        NSDictionary * attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        //NSLog(@"attributes: [%@]", attributes);
        //SS: instance of SSFileCell-class
        SSFileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
        cell.labelName.text = fileName;
        cell.labelSize.text= [NSString stringWithFormat:@"%lld bites", [attributes fileSize]];
        cell.labelModifDate.text = [NSString stringWithFormat:@"%@", [attributes fileModificationDate]];
        
        return cell;
    }
}
//Ученик-level.2
//SS: conditional permission. Called just AFTER you press Edit-button. Is called for EVERY row (one by one).
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//Ученик-level.2
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //part1 - remove from phisical drive
    NSError* error = nil;
    NSString* objectPath = [self pathForObjectAtIndexPath:indexPath];
    NSLog(@"removing object. path: %@", objectPath);
    [[NSFileManager defaultManager] removeItemAtPath:objectPath error:&error];
    if (error) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    }
    //part2 - remove from datasource-table
    NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:self.contentsArray];
    [tempArray removeObjectAtIndex:indexPath.row];
    self.contentsArray = tempArray;
    //part3 - remove from tableView
    [self.tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

//SS: How to serf via folders !!!
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isDirectoryAtIndexPath:indexPath]) {
        return 44.f;
    } else {
        return  80.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* objectPath = [self pathForObjectAtIndexPath:indexPath];
    //SS: cheking if object is folder - we will open it
    if ([self isDirectoryAtIndexPath:indexPath]) {
        NSLog(@"MARK: isDirectoryAtIndexPath --> YES");
        
        //SS: 1-st way. running via code. Common way
        /*
        SSDirectoryTableViewController* vc = [[SSDirectoryTableViewController alloc] initWithFolderPath: objectPath];
        [self.navigationController pushViewController:vc animated:YES];
         */
        //SS: 2-nd way. running via storyboard. Common way
        
        SSDirectoryTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryTableViewController"];
        vc.pathProp=objectPath;
//SS: IMPORTANTE !!! method bellow DOESN'T work without navigation Controller, that was created in storyoard !!! create it first (with assigning of rootViewController via "drag and drop")
        [self.navigationController pushViewController:vc animated:YES];
         
        
        //SS: 3-rd way. Additional
        /*
        self.selectedPath = objectPath;
        [self performSegueWithIdentifier:@"SegueToItself" sender:nil];
         */
    }
}

#pragma mark -  Segue
//SS: this method is called only if you use segue from storyboard
-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier [%@]", identifier);
    return YES;
}
//SS: method for 3-rd way in didSelectRowAtIndexPath-method
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender	{
    NSLog(@"prepareForSegue [%@]", segue.identifier);
    SSDirectoryTableViewController* destinationVC = segue.destinationViewController;
    destinationVC.pathProp = self.selectedPath;
}

#pragma mark - MyAdditionalMethods
-(NSString*) pathForObjectAtIndexPath: (NSIndexPath*) indexPath {
    NSString* objectName = [self.contentsArray objectAtIndex:indexPath.row];
    NSString* objectPath = [self.pathProp stringByAppendingPathComponent:objectName];
    return objectPath;
}
//Ученик-level.1
-(void) addFolderAction: (UIBarButtonItem*) sender {
    //Manipulations in datasource (array)
    NSString* newFolderName;
    if (newFolderCount==0) {
        newFolderName = @"new folder";
    } else {
        newFolderName = [NSString stringWithFormat:@"new folder #%d", newFolderCount];
    }
    newFolderCount = newFolderCount+1;
    if ([self.contentsArray containsObject:newFolderName]) {
        newFolderName = [newFolderName stringByAppendingString:@" (copy)"];
    }
    //part1 - add to phisical drive
    //Manipulations with NSFileManadger
    //SS: !!! here is you set up name for new folder, via adding new name to the path
    NSString* newFolderPath = [self.pathProp stringByAppendingPathComponent:newFolderName];
    NSError* error;
    BOOL isSucces = [[NSFileManager defaultManager] createDirectoryAtPath:newFolderPath
                                              withIntermediateDirectories:YES
                                                               attributes:nil
                                                                    error:&error];
    if (error) {
        NSLog(@"ERROR IS: %@", [error localizedDescription]);
    }
    NSLog(@"isSucces creation of directory?: %d", isSucces);
    
    //part2 - add to datasource-table
    //moved into part3
    
    //good way, with visual effects
    [self.tableView beginUpdates];
    NSInteger insertedObjectIndex = [self.contentsArray count]; //because it's always last
    //part2 - add to datasource-table
    NSMutableArray* tempArray  = [[NSMutableArray alloc] initWithArray:self.contentsArray];
    [tempArray addObject:newFolderName];
    self.contentsArray = tempArray;
    tempArray = nil;
    //NSLog(@"array with new folder: %@", self.contentsArray);
    
    NSIndexPath* indPath = [NSIndexPath indexPathForItem:insertedObjectIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}
//Супермен-level. How to extract folder's size
- (unsigned long long int)folderSizeForPath:(NSString *)folderPath {
    NSError* error = nil;
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    if (error) {
        NSLog(@"subpathsOfDirectoryAtPath error: %@", error.localizedDescription);
    }
    unsigned long long int fileSize = 0;
    
    for (NSString* fileName in filesArray) {
        NSError* error = nil;
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:&error];
        if (error) {
            NSLog(@"filesEnumerator error: %@", error.localizedDescription);
        }
        //unsigned long long currentSize = [fileDictionary fileSize];
        fileSize += [fileDictionary fileSize];
    }
    return fileSize;
}

-(NSArray*) sortedArrayByCertainLogicFromArray: (NSArray*) incomingArray {
    //Студент-level.3 start point
    NSComparisonResult (^compareThis) (id obj1, id obj2);
    compareThis = ^ (id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    };
    //start of block compareIsFolder
    NSComparisonResult (^compareIsFolder)(id obj1, id obj2);
    compareIsFolder = ^(id obj1, id obj2) {
        //create path for objects
        NSString* obj1Path = [self.pathProp stringByAppendingPathComponent:obj1];
        NSString* obj2Path = [self.pathProp stringByAppendingPathComponent:obj2];
        //SS: variant1. Brilliant solution!
        BOOL obj1IsDirectory = NO;
        BOOL obj2IsDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:obj1Path isDirectory:&obj1IsDirectory];
        [[NSFileManager defaultManager] fileExistsAtPath:obj2Path isDirectory:&obj2IsDirectory];
        
        if (! obj1IsDirectory && ! obj2IsDirectory) {
            return NSOrderedSame;
        } else if (obj1IsDirectory && obj2IsDirectory) {
            return NSOrderedSame;
        } else if (obj1IsDirectory && ! obj2IsDirectory) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    };
    //end of block compareIsFolder
    
    //SS; it's VERY helpful that we can create descriptor without key, only by comparator
    NSSortDescriptor* descriptor1 = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES comparator:compareIsFolder];
    NSSortDescriptor* descriptor2 = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES comparator:compareThis];
    NSArray* descriptorsArray = @[descriptor1, descriptor2];
    NSArray* tempArray2 = [self.contentsArray sortedArrayUsingDescriptors:descriptorsArray];
    return tempArray2;
    //Студент-level.3 end point
}

#pragma mark - NSFileManagerDelegate
//SS: can't activate this method !
// step 33
- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path {
    NSLog(@"delegate method is done shouldRemoveItemAtPath");
    return YES;
}

@end


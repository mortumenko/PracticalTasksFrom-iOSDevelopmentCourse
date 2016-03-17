//
//  SSDirectoryTableViewController.m
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SSDirectoryTableViewController.h"
static int newFolderCount;

@interface SSDirectoryTableViewController ()

@property (strong, nonatomic) NSString* pathProp; //SS: step1
@property (strong, nonatomic) NSArray* contentsArray; //SS: step2

@end

@implementation SSDirectoryTableViewController
//SS: step 4
-(id) initWithFolderPath:(NSString*) path {
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.pathProp = path;
    }
    NSError* error = nil;
    self.contentsArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.pathProp
                                                                        error:&error];
    if (error) {
        NSLog(@"ERROR IS: %@. Dictionary: %@", [error localizedDescription], error.userInfo);
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
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.pathProp lastPathComponent];
    
    //can't use it because we need editBtton on the right
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem* BBItem = [[UIBarButtonItem alloc] initWithTitle:@"Go to root"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backToRootAction:)];
        self.navigationItem.rightBarButtonItem = BBItem;
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.tableView.editing = YES; //if this one is activated we can't touch (select) rows
    
    //apple: A Boolean value indicating whether the left items are displayed in addition to the back button.
    self.navigationItem.leftItemsSupplementBackButton = YES;
    //SS: creating button for adding new folder
    UIBarButtonItem* BBItemAdd = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addFolderAction:)];
    self.navigationItem.leftBarButtonItem = BBItemAdd;
    
    [[NSFileManager defaultManager] setDelegate:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}
-(void) viewDidAppear:(BOOL)animated {
    /*
    NSLog(@"path = %@", self.pathProp);
    NSLog(@"view controllers on stack = %lu", (unsigned long)[self.navigationController.viewControllers count]);
    NSLog(@"index on stack  = %lu", (unsigned long)[self.navigationController.viewControllers indexOfObject:self]);
     */
    
//    NSLog(@"storage size for short: %lu", sizeof(short));
//    NSLog(@"storage size for unsigned short: %lu", sizeof(unsigned short));
//    NSLog(@"storage size for long: %lu", sizeof(long));
//    NSLog(@"storage size for int: %lu", sizeof(int));
//    NSLog(@"storage size for float: %lu", sizeof(float));
//    NSLog(@"storage size for NSInteger: %lu", sizeof(NSInteger));
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
    NSString* fileName = [self.contentsArray objectAtIndex:indexPath.row]; //SS: name of file in parsed directory
    NSString* filePath = [self.pathProp stringByAppendingPathComponent:fileName]; //SS: in method bellow fileExistsAtPath must be made by adding "parsed directory path" and "file (array-item)-name"
    BOOL isDirectory = NO;
    //SS: We don't take answer of method, we use "out parameter" (this is something new for me). This parameter will tell us about "is Directory"-question
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}

#pragma mark - Actions
-(void)backToRootAction: (UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
//part3 - add to tableView
//bad way, without visual effects
    //[self.tableView reloadData];
    
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
//step 34:
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"counter value is: %lu", [self.contentsArray count]);
    //NSLog(@"section is [%ld]. first folder is: [%@]", (long)section, [self.contentsArray objectAtIndex:0]);
    return [self.contentsArray count];
}

//GENERAL CELL-CREATION
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        //NSLog(@"cell created");
    } else {
        //NSLog(@"cell reused");
    }
    NSString* fileName = [self.contentsArray objectAtIndex:indexPath.row]; //SS: name of file in parsed directory
    cell.textLabel.text = fileName;

    //SS: how to check if array-item is file or directory? if YES - we use image for cell
    if ([self isDirectoryAtIndexPath:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"Folder-icon.png"];
//Супермен-level. How to extract folder's size
        NSString* folderPath = [self pathForObjectAtIndexPath:indexPath];
        unsigned long long folderSize = [self folderSizeForPath:folderPath];
        float kBFolderSize = folderSize/1024.f;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f kB", kBFolderSize];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"Document-icon.png"];
        //checking for a hidden files
        if ([fileName hasPrefix:@"."]) {
            cell.backgroundColor = [UIColor lightGrayColor];
            //cell.detailTextLabel.text = @"hidden file";
        }
//Master-level. How to extract file's size
        NSInteger fileSize = [self getFileSizeForIndexPath:indexPath];
        float kBFileSize = fileSize/1024.f;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f kB", kBFileSize];
    }
    
    return cell;
}

//Ученик-level.2
//SS: conditional permission. Is done just AFTER you press Edit-button (changed self.tableView.editing = YES), BEFORE you tried to delete (edit). Is called  for EVERY row (one by one).
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


//Ученик-level.2
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//part1 - remove from phisical drive
    NSError* error = nil;
    NSString* objectName = [self.contentsArray objectAtIndex:indexPath.row];
    NSString* objectPath = [self.pathProp stringByAppendingPathComponent:objectName];
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
-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return  [NSString stringWithFormat:@"path: %@", self.pathProp];
}

//SS: How to serf via folders !!!
#pragma mark - UITableViewDelegate
//step 33-1
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* fileName = [self.contentsArray objectAtIndex:indexPath.row];
    //NSLog(@"fileName: %@. self.pathProp: %@", fileName, self.pathProp);
    NSString* objectPath = [self.pathProp stringByAppendingPathComponent:fileName];

    //SS: cheking if object is folder - we will open it
    if ([self isDirectoryAtIndexPath:indexPath]) {
        SSDirectoryTableViewController* vc = [[SSDirectoryTableViewController alloc] initWithFolderPath: objectPath];
//SS: IMPORTANTE !!! method bellow DOESN'T work without navigation Controller, that was created in AppDelegate.m !!! create it first (with assigning of rootViewController)
        [self.navigationController pushViewController:vc animated:YES];
    }
    //SS: playing with files
    if (![self isDirectoryAtIndexPath:indexPath]) {
        [self handleTableViewIfFile:tableView forRowAtIndexPath:indexPath forObjectPath:objectPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    return @"really?";
}

#pragma mark - My Additional methods
- (void) handleTableViewIfFile: (UITableView*) tableView forRowAtIndexPath: (NSIndexPath*) indexPath forObjectPath: (NSString*) objectPath {
    
    NSString* selectedRowText = [self.contentsArray objectAtIndex:indexPath.row];
//SS: work with fileName
    if ([selectedRowText  isEqual: @"Tasksformyself.docx"]) {
            NSLog(@"Checkig is DONE. We've found file 'Tasksformyself.docx' ");
            //NSInteger levelValue = [[NSFileManager defaultManager] ];
            //unsigned size= [[NSFileManager defaultManager] fileSize];
    } else {
        NSLog(@"You've touched the file '%@' ", selectedRowText);
    }
//SS: my tring. How to delete file? Task is to delete duplicate-files
    if ([selectedRowText  containsString:@" copy"]) {
        NSLog(@"We have found duplicate-file. [%@]", selectedRowText);
//        NSLog(@"File '%@' will be removed !", selectedRowText);

        NSError* currentError = nil;
//part1 - remove from phisical drive
        //[[NSFileManager defaultManager] removeItemAtPath:objectPath error:&currentError]; //step 32-2
        if (currentError) {
            NSLog(@"ERROR IS: %@", [currentError localizedDescription]);
        }
//part2 - remove from datasource-table
        /*
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:self.contentsArray];
        [tempArray removeObjectAtIndex:indexPath.row];
        self.contentsArray = tempArray;
         */
//part3 - remove from tableView
        /*
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
         */
    }
}
-(NSString*) pathForObjectAtIndexPath: (NSIndexPath*) indexPath {
    NSString* objectName = [self.contentsArray objectAtIndex:indexPath.row];
    NSString* objectPath = [self.pathProp stringByAppendingPathComponent:objectName];
    return objectPath;
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
        unsigned long long currentSize = [fileDictionary fileSize];
        fileSize += [fileDictionary fileSize];
    }
    return fileSize;
}
//Master-level. How to extract file's size
-(unsigned long long) getFileSizeForIndexPath: (NSIndexPath*) indexPath {
    NSString* filePath = [self pathForObjectAtIndexPath:indexPath];
    NSError* error = nil;
    NSDictionary* attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    //NSLog(@"attributes library: %@", attributes);
    if (error) {
        NSLog(@"File attributes error: %@\n usr info: %@", error.localizedDescription, error.userInfo);
    }
    //to comlicated, because I retrive size via dictionary's object, and get NSNumber object
    /*
    id fileSizeObject = [attributes objectForKey:NSFileSize]; //!!! result has id type. NSNumber
    NSInteger integerFileSize = [fileSizeObject integerValue];
    */
    return [attributes fileSize];
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
    
    //SS: variant2. working but not optimal way. Based on fact that errors appears when NSFileManager can't parse content of directory at path.
    /*
     NSError* error1 = nil;
     NSError* error2 = nil;
     NSArray* array1 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:obj1Path error:&error1];
     NSArray* array2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:obj2Path error:&error2];
     
     //SS: if error is not nil than object is file
     if (error1 && error2) {
     NSLog(@"both are files");
     return NSOrderedSame;
     } else if (!error1 && !error2) {
     NSLog(@"both are folders");
     return NSOrderedSame;
     } else if (!error1 && error2) {
     NSLog(@"first is folder");
     return NSOrderedAscending;
     } else {
     NSLog(@"first is file");
     return NSOrderedDescending;
     }
     //SS: "Cocoa error 256" in localizedDescription appears when key "NSUnderlyingError" contains string "Not a directory". More correct parsing, because it's oriented to certain message, but to complicated for reading.
     if ([[error1 localizedDescription]containsString:@"Cocoa error 256"] && [[error2 localizedDescription]containsString:@"Cocoa error 256"]) {
     NSLog(@"from localizedDescription: both are files");
     }
     */
    
    return tempArray2;
    //Студент-level.3 end point
}


#pragma mark - NSFileManagerDelegate
//SS: how to assign deleagte  -see at (-viewDidLoad)
// step 33
- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path {
    NSLog(@"----------------  delegate method is done------- \n deleted file's path: %@", path);
    return YES;
}

@end


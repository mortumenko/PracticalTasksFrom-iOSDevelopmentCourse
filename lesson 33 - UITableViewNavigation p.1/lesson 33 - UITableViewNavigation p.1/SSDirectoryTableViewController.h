//
//  SSDirectoryTableViewController.h
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDirectoryTableViewController : UITableViewController <NSFileManagerDelegate>
-(id) initWithFolderPath:(NSString*) path; // step 3
@end

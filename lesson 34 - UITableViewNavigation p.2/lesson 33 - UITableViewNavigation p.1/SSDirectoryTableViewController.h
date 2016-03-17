//
//  SSDirectoryTableViewController.h
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDirectoryTableViewController : UITableViewController

@property (strong, nonatomic) NSString* pathProp; //SS: step1
@property (strong, nonatomic) NSArray* contentsArray; //SS: step2

-(id) initWithFolderPath:(NSString*) path; // step 3
-(IBAction)actionInfoCell:(id)sender;

@end

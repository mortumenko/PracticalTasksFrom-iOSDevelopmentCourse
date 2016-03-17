//
//  DummyTableViewController.m
//  lesson 33 - UITableViewNavigation p.1
//
//  Created by Admin on 12/19/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DummyTableViewController.h"

@interface DummyTableViewController ()

@end

@implementation DummyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad for DummyTableViewController is done");

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Segue
//SS: this method is called only if you use segue from storyboard
-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier [%@]", identifier);
    return YES;
}
//SS: here is you can assighn something for destination view controller of this segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender	{
    NSLog(@"prepareForSegue [%@]", segue.identifier);
}


@end

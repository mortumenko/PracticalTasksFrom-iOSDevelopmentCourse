//
//  ColourCellsTableVC.m
//  lesson 30. Homework
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ColourCellsTableVC.h"

@interface ColourCellsTableVC ()

@end

@implementation ColourCellsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem * BBItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(nothingAction)];
    BBItem.title = @"CCTVC";
    self.navigationItem.rightBarButtonItem = BBItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// I don't use it, 'course I need values to insert into the cells
- (UIColor*)randomColor {
    float redDigit = (float) (arc4random()%100)/100;
    float greenDigit = (float) (arc4random()%100)/100;
    float blueDigit = (float) (arc4random()%100)/100;
    UIColor* currentColor = [UIColor colorWithRed:redDigit green:greenDigit blue:blueDigit alpha:1.f];
    NSLog(@"WARNING! You don't want to lanch this method!");
    NSLog(@"color is RGB(%.3f; %.3f; %.3f)", redDigit,greenDigit,blueDigit);
    return currentColor;
}
//SS: it's not used
- (float)randomFromZeroToOne {
    return (float) (arc4random()%100)/100;
    //NSLog(@"rand: %.2f", randDigit);
}
//SS: pupil-level
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title = [NSString stringWithFormat:@"section # %ld", (long)section];
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //SS: when we use "reuseIdentifier" - it's mean that we don't store viewed cell, end every time when we scroll back - we see NEW cells
    static NSString* cellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        float redDigit = (float) (arc4random()%100)/100; //[self randomFromZeroToOne];
        float greenDigit = (float) (arc4random()%100)/100;
        float blueDigit = (float) (arc4random()%100)/100;
        UIColor* currentColor = [UIColor colorWithRed:redDigit green:greenDigit blue:blueDigit alpha:1.f];
        cell.backgroundColor = currentColor;

//      cell.backgroundColor = [self randomColor];
        cell.textLabel.text = [NSString stringWithFormat:@"color is RGB(%.3f; %.3f; %.3f)", redDigit,greenDigit,blueDigit];
        cell.textLabel.textColor = [UIColor yellowColor];
        //NSLog(@"section # %ld. color is RGB(%.3f; %.3f; %.3f)", (long)indexPath.section, redDigit,greenDigit,blueDigit);
        //cell.backgroundColor = [self randomColor];
        //NSLog(@"cell is created");
        return cell;
    } else {
        NSLog(@"cell reused");

    }
    // Configure the cell...
    
    return cell;
}


#pragma  mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog (@"didSelectRowAtIndexPath is done");

}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog (@"willDisplayCell is done");
}
*/


#pragma mark - Actions
-(void) nothingAction {
    NSLog (@"nothingAction is done");
}

@end

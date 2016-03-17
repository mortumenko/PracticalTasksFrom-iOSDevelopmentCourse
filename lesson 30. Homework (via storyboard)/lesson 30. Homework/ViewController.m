//
//  ViewController.m
//  lesson 30. Homework
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableProp.contentInset = insets;
    self.tableProp.scrollIndicatorInsets = insets;
    NSLog(@"MARK #1");
     */
    // Do any additional setup after loading the view, typically from a nib.
    //ColourCellsTableVC* vc = [[ColourCellsTableVC alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"MARK #3");
    // Return the number of sections.
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title = [NSString stringWithFormat:@"section # %ld", (long)section];
    NSLog(@"MARK #4");
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"MARK #5");
    return 7;
}
/* DOESN'T work
 - (UIColor)randomColor {
 CGFloat redDigit = (arc4random()%100)/100;
 CGFloat greenDigit = (arc4random()%100)/100;
 CGFloat blueDigit = (arc4random()%100)/100;
 UIColor* currentColor = [UIColor colorWithRed:redDigit green:greenDigit blue:blueDigit alpha:1];
 return currentColor;
 } */

- (float)randomFromZeroToOne {
    return (float) (arc4random()%100)/100;
    //NSLog(@"rand: %.2f", randDigit);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        float redDigit = (float) (arc4random()%100)/100; //[self randomFromZeroToOne];
        float greenDigit = (float) (arc4random()%100)/100; //[self randomFromZeroToOne];
        float blueDigit = (float) (arc4random()%100)/100; //[self randomFromZeroToOne];
        UIColor* currentColor = [UIColor colorWithRed:redDigit green:greenDigit blue:blueDigit alpha:1.f];
        cell.backgroundColor = currentColor;
        cell.textLabel.text = [NSString stringWithFormat:@"color is RGB(%.3f; %.3f; %.3f)", redDigit,greenDigit,blueDigit];
        cell.textLabel.textColor = [UIColor yellowColor];
        //cell.backgroundColor = [self randomColor];
        return cell;
    }
    // Configure the cell...
    
    return cell;
}

@end

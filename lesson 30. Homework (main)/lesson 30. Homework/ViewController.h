//
//  ViewController.h
//  lesson 30. Homework
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableProp;
@property (strong, nonatomic) NSMutableArray* manyObjectsArray;
@property (strong, nonatomic) NSMutableArray* manyStudentsArray;
//SS: bad way (not MVC)
//@property (strong, nonatomic) NSMutableArray* grade2Students;
//@property (strong, nonatomic) NSMutableArray* grade3Students;
//@property (strong, nonatomic) NSMutableArray* grade4Students;
//@property (strong, nonatomic) NSMutableArray* grade5Students;

@end


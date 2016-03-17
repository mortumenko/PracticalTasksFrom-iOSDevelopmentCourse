//
//  GradeTVC.h
//  lesson 36. Homework
//
//  Created by Admin on 3/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GradeTVCDelegateProtocol;

@interface GradeTVC : UITableViewController
@property (weak, nonatomic) id <GradeTVCDelegateProtocol> delegate;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemProperty;
@property (assign, nonatomic) int chosenGrade;
- (IBAction)actionGrade1:(UIButton *)sender;
- (IBAction)actionGrade2:(UIButton *)sender;
- (IBAction)actionGrade3:(UIButton *)sender;
- (IBAction)actionGrade4:(UIButton *)sender;
- (IBAction)actionGrade5:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *grade1Outlet;
@property (weak, nonatomic) IBOutlet UIButton *grade2Outlet;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *checkBoxesCollection;

@end

@protocol GradeTVCDelegateProtocol <NSObject>

@required
-(void) gradeValueChangedForGradeTVC: (GradeTVC*) lastInstance;

@end
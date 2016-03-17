//
//  GradeTVC.m
//  lesson 36. Homework
//
//  Created by Admin on 3/1/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "GradeTVC.h"

//SS: superman-level
static int lastGradeLevel = 0;
static int countLoading = 0;

typedef enum {
    gradeUncomplitedSchool = 1,
    gradeSchool = 2,
    gradeUncomplitedUniversity = 3,
    gradeUniversity = 4,
    gradePhD = 5
}gradeList; //if you add new item to this list, you must add an item in     NSDictionary* dict at implementation of selector (gradeValueChangedForGradeTVC:(GradeTVC *)lastInstance) in InitialTVC.m

@interface GradeTVC ()

@end

@implementation GradeTVC


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItemProperty.title = @"grade-title from code via property";
    self.navigationItem.title = @"grade-title from code"; //DOESN'T work !!!

    countLoading = countLoading +1;
    NSLog(@"countLoading is: %d", countLoading);
    //set images for both states
    for (UIButton* button in self.checkBoxesCollection) {
        [button setImage:[UIImage imageNamed:@"32p_checked_checkbox.png"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"32p_unchecked_checkbox.png"] forState:UIControlStateNormal];
    }
    
    // if this is not first loading of popover-window, we set self.chosenGrade from nil to last value, that is keeped in static variable lastGradeLevel and set corresponding checkbox to Selected-state
    if (countLoading > 1) {
        self.chosenGrade = lastGradeLevel;
        
        if (lastGradeLevel!=0) {
            int index = lastGradeLevel-1;
            UIButton* lastChosenCheckBox = [self.checkBoxesCollection objectAtIndex:index];
            [lastChosenCheckBox setSelected:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) dealloc {
    lastGradeLevel = self.chosenGrade;
    [self.delegate gradeValueChangedForGradeTVC:self];
    NSLog(@"GradeTVC.h is deallocated. Grade [%d] is loaded to static lastGradeLevel", lastGradeLevel);
}


#pragma mark - Actions from UIControlls
- (IBAction)actionGrade1:(UIButton *)sender {
    self.grade1Outlet.selected = ! self.grade1Outlet.selected; //reversing Selected-state
    if (sender.isSelected == YES) {
        [self setOtherButtonsToUnselected];
        [sender setSelected:YES];
        self.chosenGrade = gradeUncomplitedSchool;
        NSLog(@"gradeUncomplitedSchool is accepted");
    } else {
        self.chosenGrade = 0;
    }
}

- (IBAction)actionGrade2:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected == YES) {
        [self setOtherButtonsToUnselected];
        [sender setSelected:YES];
        self.chosenGrade = gradeSchool;
        NSLog(@"gradeSchool is accepted");
    } else {
        self.chosenGrade = 0;
    }
}

- (IBAction)actionGrade3:(UIButton *)sender {
    [sender setSelected:![sender isSelected]];
    if (sender.isSelected == YES) {
        [self setOtherButtonsToUnselected];
        [sender setSelected:YES];
        self.chosenGrade = gradeUncomplitedUniversity;
        NSLog(@"gradeUncomplitedUniversity is accepted");
    } else {
        self.chosenGrade = 0;
    }
}

- (IBAction)actionGrade4:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected == YES) {
        [self setOtherButtonsToUnselected];
        [sender setSelected:YES];
        self.chosenGrade = gradeUniversity;
        NSLog(@"gradeUniversity is accepted");
    } else {
        self.chosenGrade = 0;
    }
}

- (IBAction)actionGrade5:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected == YES) {
        [self setOtherButtonsToUnselected];
        [sender setSelected:YES];
        self.chosenGrade = gradePhD;
        NSLog(@"gradePhD is accepted");
    } else {
        self.chosenGrade = 0;
    }
}

#pragma mark - Additional methods

-(void) setOtherButtonsToUnselected {
    for (UIButton* button in self.checkBoxesCollection) {
        [button setSelected:NO];
    }
}

@end

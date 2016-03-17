//
//  VCForDatePicker.m
//  lesson 36. Homework
//
//  Created by Admin on 2/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "VCForDatePicker.h"
static int countOfLoadings = 0;
static NSDate* lastChosenDate = nil;
@interface VCForDatePicker ()

@end

@implementation VCForDatePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"datePicker VC did load");
    self.datePickerOutlet.datePickerMode = UIDatePickerModeDate;
    countOfLoadings = countOfLoadings+1;
    if (countOfLoadings > 1) {
        self.datePickerOutlet.date = lastChosenDate;
    }
    //NSLog(@"countOfLoadings for DatePicker: %d", countOfLoadings);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) dealloc {
    [self.delegate gotNewDateFromDatePicker:self]; //Мастер 6,7 - solution recommended by Al.Sk.
    lastChosenDate = self.datePickerOutlet.date;
    NSLog(@"VCForDatePicker is deallocated");
}

- (IBAction)actionDateChanged:(UIDatePicker *)sender {
    //NSLog(@"curent date: %@", sender.date);
}


@end

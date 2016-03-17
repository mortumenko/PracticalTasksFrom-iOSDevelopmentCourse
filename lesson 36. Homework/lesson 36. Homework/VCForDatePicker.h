//
//  VCForDatePicker.h
//  lesson 36. Homework
//
//  Created by Admin on 2/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerDelegate;

@interface VCForDatePicker : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
@property (weak, nonatomic) id <DatePickerDelegate> delegate;
- (IBAction)actionDateChanged:(UIDatePicker *)sender;

@end

@protocol DatePickerDelegate <NSObject>

@required
- (void) gotNewDateFromDatePicker: (VCForDatePicker*) currentDP;

@end

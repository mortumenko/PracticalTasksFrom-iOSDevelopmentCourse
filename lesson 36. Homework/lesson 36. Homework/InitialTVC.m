//
//  InitialTVC.m
//  lesson 36. Homework
//
//  Created by Admin on 2/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "InitialTVC.h"
#import "InfoViewController.h"
#import "VCForDatePicker.h"
#import "GradeTVC.h"

@interface InitialTVC () <UIPopoverControllerDelegate, DatePickerDelegate, GradeTVCDelegateProtocol>
@property (strong, nonatomic) UIPopoverController* popoverProp; //to be able point popover to the nil after dismissing
@property (strong, nonatomic) NSDate * extractedDate;

@end

@implementation InitialTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"person's info";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - MyActions
//Студент-Master
- (IBAction)actionFocusOnGrade:(UITextField *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender resignFirstResponder];
    });
    GradeTVC* gradeVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"GradeTVC identifier"];
    gradeVCInstance.delegate = self;
    UIPopoverController* popoverForGrade = [[UIPopoverController alloc] initWithContentViewController:gradeVCInstance];
    [popoverForGrade presentPopoverFromRect:sender.frame
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
    popoverForGrade.popoverContentSize = CGSizeMake(self.view.frame.size.width, 500);
}

- (IBAction)actionFocusOnBirthDayTextField:(UITextField *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender resignFirstResponder];
    });
    VCForDatePicker* datePickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker VC"];
    datePickerVC.delegate = self; //Мастер 6,7 - solution recommended by Al.Sk.
    
    UIPopoverController* popoverForDatePicker = [[UIPopoverController alloc] initWithContentViewController:datePickerVC];
    
    [popoverForDatePicker presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    popoverForDatePicker.popoverContentSize = CGSizeMake(self.view.frame.size.width, 500);
    popoverForDatePicker.delegate = self;
    self.popoverProp = popoverForDatePicker;
    //NSLog(@"sender.frame:\n width - %f, height - %f, x - %f, y - %f", sender.frame.size.width, sender.frame.size.height, sender.frame.origin.x, sender.frame.origin.y);
    NSLog(@"actionFocusOnBirthDayTextField");
}
//Ученик
- (IBAction)actionShowInfo:(id)sender {
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat viewWidth = self.view.frame.size.width;
    InfoViewController* infoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPopover"];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"Idiom: iPad");
        UIPopoverController* popover1 = [[UIPopoverController alloc] initWithContentViewController:infoVC];
        [popover1 presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        popover1.popoverContentSize = CGSizeMake(viewWidth/2, viewHeight-50);
        popover1.delegate = self;
        self.popoverProp = popover1;
    } else {
        NSLog(@"Idiom: iPhone");
        [self showAsModalController:infoVC];
    }

}
-(void) showAsModalController: (UIViewController*) receivedVC {
    [self presentViewController:receivedVC animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

# pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    //Мастер 6,7 - my solution (solution recommended by Al.Sk. see at DatePickerDelegate)
    /*
    UIViewController* instance = self.popoverProp.contentViewController;
    VCForDatePicker* instanceDatePicker = instance;
    NSLog(@"extractedDate is %@", instanceDatePicker.datePickerOutlet.date);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy"];
    NSString* tempString = [formatter stringFromDate:instanceDatePicker.datePickerOutlet.date];
    self.dateOfBirthOutlet.text = tempString;
    */
    self.popoverProp = nil;
    NSLog(@"popoverControllerDidDismissPopover is done");
    
}
//Мастер 6,7 - solution recommended by Al.Sk.
#pragma mark - DatePickerDelegate
- (void) gotNewDateFromDatePicker:(VCForDatePicker *)currentDP {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy"];
    NSString* tempString = [formatter stringFromDate:currentDP.datePickerOutlet.date];
    self.dateOfBirthOutlet.text = tempString;
    self.extractedDate = currentDP.datePickerOutlet.date;
    NSLog(@"value for textFiled is setUp");
}

#pragma mark - GradeTVCDelegateProtocol

- (void) gradeValueChangedForGradeTVC:(GradeTVC *)lastInstance {
    NSLog(@"gradeValueChangedForGradeTVC is done by delegate");
    NSString* string;
    NSNumber* receivedIndex = [NSNumber numberWithInt:lastInstance.chosenGrade];
    NSDictionary* dict = @{@0 : @"no chosen grade",
                           @1 : @"UncomplitedSchool",
                           @2 : @"School",
                           @3 : @"UncomplitedUniversity",
                           @4 : @"University",
                           @5 : @"PhD"};
    id object = [dict objectForKey:receivedIndex];
    string = object;
    self.gradeTextField.text = string;
}

@end

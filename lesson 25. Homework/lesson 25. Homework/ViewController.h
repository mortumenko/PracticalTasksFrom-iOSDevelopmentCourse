//
//  ViewController.h
//  lesson 25. Homework
//
//  Created by Admin on 8/19/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
//enum -it's integer, but inside some code bellow now you can assign (or check in if-else) not integer-digits but their names (labels). But digiv must arrive from property of some object or so on.
typedef enum {
    multyplying=10,
    dividing,
    minusing,
    adding
} operatorsList;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *outputFieldLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgrImageView;
//@property operatorsList usersOperator;

//@property (assign, nonatomic) CGFloat curFontSize;
@property (assign, nonatomic) CGFloat currentDigit;
@property (assign, nonatomic) CGFloat firstDigit;
@property (assign, nonatomic) CGFloat result;
@property (assign, nonatomic) BOOL isFirstCalculation;
@property (assign, nonatomic) BOOL isOn;
@property (strong, nonatomic) NSString * chosenOperator;
@property (assign, nonatomic) NSInteger chosenOperatorTag;
- (IBAction)onOffSwitchAction:(UISwitch *)sender;




- (IBAction)digitButtonAction:(UIButton *)sender;
- (IBAction)operatorsButtonsAction:(UIButton *)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)enterAction:(id)sender;


@end


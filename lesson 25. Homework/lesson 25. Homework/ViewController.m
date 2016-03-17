//
//  ViewController.m
//  lesson 25. Homework
//
//  Created by Admin on 8/19/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void) dealloc {
    NSLog(@"object of View Controller class has been deallocated");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //it doesn't work
    self.backgrImageView.image=[UIImage imageNamed:@"archEnemyLogo"];
    // Do any additional setup after loading the view, typically from a nib.
    self.isFirstCalculation=YES;
    self.isOn=NO;
    //self.outputFieldLabel.enabled=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons
- (IBAction)onOffSwitchAction:(UISwitch *)sender {
    if (self.isOn) {
        self.isOn=NO;
        self.outputFieldLabel.text=nil;
        self.currentDigit = 0;
        self.firstDigit = 0;
        self.result = 0;
        self.isFirstCalculation=YES;
    } else {
        self.isOn=YES;
    }
}

- (IBAction)digitButtonAction:(UIButton *)sender {
    if (self.isOn) {
        NSInteger newDigitLocal = self.currentDigit*10+sender.tag;
        self.currentDigit = newDigitLocal;
        self.outputFieldLabel.text=[NSString stringWithFormat:@"%ld", (long)newDigitLocal];
    }
    
    
}
- (IBAction)operatorsButtonsAction:(UIButton *)sender {
    if (self.isOn) {
        NSString *value;
        if (sender.tag==adding) {
            value=@"+";
        } else if (sender.tag==minusing){
            value=@"-";
        } else if (sender.tag==multyplying){
            value=@"*";
        } else if (sender.tag==dividing){
            value=@"/";
        } else {value=@"unknown button";};
        self.chosenOperator = value;
        self.chosenOperatorTag = sender.tag;
        self.outputFieldLabel.text=[NSString stringWithFormat:@"%@", value];
        
        // example valid ENUM operation
        /*
         int userOperator1 = dividing;
         int userOperator2 = multyplying;
         NSLog(@"your choise are: %d, %d, %d", userOperator1, userOperator2, adding); */
        
        //checking if firstDigit must keep value from previous result or take new from currentDigit
        if (self.isFirstCalculation) {
            self.firstDigit=self.currentDigit;
        }
        self.currentDigit = 0; // mistake, if I assign to "nil"
    }
}

- (IBAction)cancelButtonAction:(id)sender {
    if (self.isOn) {
        self.outputFieldLabel.text=nil;
        self.currentDigit = 0;
        self.firstDigit = 0;
        self.outputFieldLabel.text=@"0";
        //to allow firstDigit take value from new currentDigit
        self.isFirstCalculation=YES;
    }

    
}

- (IBAction)enterAction:(id)sender {
    // calculations must be here:
    //NSInteger resultLocal;
    if (self.isOn) {
        if (self.chosenOperatorTag==dividing) {
            self.result=self.firstDigit/self.currentDigit;
        } else if (self.chosenOperatorTag==multyplying) {
            self.result=self.firstDigit*self.currentDigit;
        } else if (self.chosenOperatorTag==minusing) {
            self.result=self.firstDigit-self.currentDigit;
        } else if (self.chosenOperatorTag==adding)
        // another variant:
        //else if ([self.chosenOperator isEqual:@"+"])
        {
            self.result=self.firstDigit+self.currentDigit;
        } else {
            NSLog(@"Unknown operator");
        }
        
        //saving result as first Digit for next calculations
        self.firstDigit=self.result;
        self.outputFieldLabel.text=[NSString stringWithFormat:@"%.4f", self.result];
        self.isFirstCalculation=NO;
    }

}

@end

/*
 self.curFontSize=[UIFont systemFontSize];
 //CGFloat currentFontSize=[UIFont systemFontSize];
 NSLog(@"current font size is: %f", self.curFontSize);
 self.outputFieldLabel.font=[UIFont systemFontOfSize:(self.curFontSize+10)];
 */

// self.outputFieldLabel.text=[NSString stringWithFormat:@"%ld", sender.tag];

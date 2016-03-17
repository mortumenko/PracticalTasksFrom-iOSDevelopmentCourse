//
//  RegistrationFormTVC.m
//  lesson 29. Homework-4
//
//  Created by Admin on 2/4/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "RegistrationFormTVC.h"

//SS: parametrs for phone-number formating
static const int localNumberMaxLenght = 7;
static const int areaCodeMaxLenght = 3;
static const int countryCodeMaxLenght = 3;
static int maxLenght = localNumberMaxLenght+areaCodeMaxLenght+countryCodeMaxLenght;

//SS: creating keys
static  NSString* keyFirstName = @"FirstName";
static  NSString* keyLastName = @"LastName";
static  NSString* keyLogin = @"Login";
static  NSString* keyAge = @"Age";
static  NSString* keyPhoneNumber = @"PhoneNumber";
static  NSString* keyEmail = @"Email";
static  NSString* keyIsReady = @"IsReady";
static  NSString* keyGender = @"Gender";
static  NSString* keyLevel = @"Level";


@interface RegistrationFormTVC ()

@end

@implementation RegistrationFormTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//SS: briliant way for assign delegate for many abjects
    for (UITextField * currentTextF in self.allTextFields) {
        currentTextF.delegate = self;
    }
    self.switchForReady.on  = NO;
    [self.genderSegmContr setTitle:@"Female" forSegmentAtIndex:1];
    
    [self loadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITextFieldDelegate
//SS: Ученик -> Студент - level.6
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSUInteger count = [self.allTextFields count];
    NSUInteger currentIndex = [self.allTextFields indexOfObject:textField];
    if ([textField isEqual:self.emailTextField]) {
        [textField resignFirstResponder];
    }
    if (currentIndex < (count-1)) {
        [[self.allTextFields objectAtIndex:(currentIndex+1)] becomeFirstResponder];
    }
    return YES;
}
//SS: Студент - level.8
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSUInteger currentIndex = [self.allTextFields indexOfObject:textField];
    UILabel* linkedLabel = [self.allLabelsForOutput objectAtIndex:currentIndex];
    linkedLabel.text = nil;
    return  YES;
    
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"-------------New Input-----------");
//SS: Студент - level.7
    NSUInteger currentIndex = [self.allTextFields indexOfObject:textField];
    UILabel* linkedLabel = [self.allLabelsForOutput objectAtIndex:currentIndex];
    linkedLabel.text = [textField.text stringByAppendingString:string];

//SS:Мастер-level
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//SS: checking for not-digit input
    if ([textField isEqual:self.ageTextField] || [textField isEqual:self.phoneTextField]) {
        NSLog(@"------------- checking not-digit input -----------");
        NSCharacterSet* invalidSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:invalidSet];
        if ([components count]>1) {
            NSLog(@"NOT VALID");
            return NO;
        }
    }
    //SS: checking for extra-long phoneNumber and converting of phone-number
    if ([textField isEqual:self.phoneTextField]) {
        if (textField.text.length > (maxLenght-1)) {
            NSLog(@"maximum lenght [%d] is exceeded", maxLenght);
            return NO;
        }
        textField.text = [self makingBeautyForPhoneNumberFromString:newString];
        return NO;
    }
//SS: superman-level
    if ([textField isEqual:self.emailTextField]) {
        return [self emailValidationForString:string];
    }
    return  YES;
}



#pragma mark - My additional methods
//SS: superman-level
-(BOOL) emailValidationForString: (NSString*) string {
    NSCharacterSet *invalidSymbols = [NSCharacterSet characterSetWithCharactersInString:@"/[*+]{}|'!#$%^&()=;:<>"];
    NSLog(@"string is: %@", string);
    
    NSArray* components = [string componentsSeparatedByCharactersInSet:invalidSymbols];
    if ([components count]>1) {
        NSLog(@"NOT VALID");
        return NO;
    }
    if (self.emailTextField.text.length>20) {
        NSLog(@"You exeeded maximum lenght");
        return NO;
    }
    if ([string isEqualToString:@"@"]) {
        if (self.isHasAtSighn) {
            NSLog(@"it's forbidden to type more than one at-sighn");
            return NO;
        }
        self.isHasAtSighn = YES;
    }
    return YES;
}

-(NSString*) makingBeautyForPhoneNumberFromString:(NSString *) sourceString {
    NSLog(@"------------- making beauty -----------");
    NSCharacterSet * invalidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    //but we get dirty string, like this, so we need to make purge. +XX (XXX) XXX-XXXX will be converted to XXXXXXXXXXXX
    //NSLog(@"dirty new string is: %@", sourceString);
    NSArray * validComponents = [sourceString componentsSeparatedByCharactersInSet:invalidationSet];
    sourceString = [validComponents componentsJoinedByString:@""];
    //NSLog(@"purged new string is: %@", sourceString);
    
    //alloc init empty resultString
    NSMutableString* resultString = [NSMutableString string];
    
    //local number
    NSInteger localNumberLenght = MIN([sourceString length], localNumberMaxLenght);
    if (localNumberLenght > 0) {
        NSString* number = [sourceString substringFromIndex:(int)[sourceString length] - localNumberLenght];
        [resultString appendString:number];
        //NSLog(@"number is: %@", number);
        //NSLog(@"1-st checking of resultString is: %@", resultString);
        if ([resultString length]>3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    //area-code-number
    if ([sourceString length]>localNumberMaxLenght) {
        NSInteger arealCodeLenght = MIN([sourceString length]-localNumberMaxLenght, areaCodeMaxLenght);
        NSRange areaRange = NSMakeRange((int)[sourceString length]-localNumberMaxLenght-arealCodeLenght, arealCodeLenght);
        NSString* area = [sourceString substringWithRange:areaRange];
        area = [NSString stringWithFormat:@"(%@)", area];
        [resultString insertString:area atIndex:0];
    }
    
    //country code number
    if ([sourceString length]>localNumberMaxLenght+areaCodeMaxLenght) {
        NSInteger countryCodeLenght = MIN([sourceString length]-localNumberMaxLenght - areaCodeMaxLenght, countryCodeMaxLenght);
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLenght);
        NSString* countryCode = [sourceString substringWithRange:countryCodeRange];
        countryCode = [NSString stringWithFormat:@"+%@", countryCode];
        [resultString insertString:countryCode atIndex:0];
    }
    return resultString;
}

#pragma mark - Save and load

-(void) saveUserInfo {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:(self.firstNameTextField.text) forKey:keyFirstName];
    [userDefaults setObject:(self.lastNameTextField.text) forKey:keyLastName];
    [userDefaults setObject:(self.loginTextField.text) forKey:keyLogin];
    [userDefaults setObject:(self.ageTextField.text) forKey:keyAge];
    [userDefaults setObject:(self.phoneTextField.text) forKey:keyPhoneNumber];
    [userDefaults setObject:(self.emailTextField.text) forKey:keyEmail];
    [userDefaults setBool:(self.switchForReady.isOn) forKey:keyIsReady];
    [userDefaults setInteger:(self.genderSegmContr.selectedSegmentIndex) forKey:keyGender];
    [userDefaults setFloat:(self.levelSlider.value) forKey:keyLevel];

    [userDefaults synchronize];
}

-(void) loadUserInfo {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.firstNameTextField.text = [userDefaults objectForKey:keyFirstName];
    self.lastNameTextField.text = [userDefaults objectForKey:keyLastName];
    self.loginTextField.text = [userDefaults objectForKey:keyLogin];
    self.ageTextField.text = [userDefaults objectForKey:keyAge];
    self.phoneTextField.text = [userDefaults objectForKey:keyPhoneNumber];
    self.emailTextField.text = [userDefaults objectForKey:keyEmail];
    self.switchForReady.on = [userDefaults boolForKey:keyIsReady];
    self.genderSegmContr.selectedSegmentIndex = [userDefaults integerForKey:keyGender];
    self.levelSlider.value = [userDefaults floatForKey:keyLevel];
}

- (IBAction)isReadyAction:(UISwitch *)sender {
    self.isReadyLabel.text = [NSString stringWithFormat:@"%@", (sender.on) ? @"ready" : @"not ready"];
}

- (IBAction)genderChangedAction:(UISegmentedControl *)sender {
    self.genderLabel.text = [NSString stringWithFormat:@"%@", (sender.selectedSegmentIndex) ? @"female" : @"male"];
}

- (IBAction)levelChangedAction:(UISlider *)sender {
    self.levelLabel.text = [NSString stringWithFormat:@"level is %.2f", sender.value];
}

- (IBAction)saveAction:(id)sender {
    [self saveUserInfo];
}

// pragma mark - Table view data source is not needed for static cells

@end

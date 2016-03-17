//
//  ViewController.m
//  lesson 27-28. Homework
//
//  Created by Admin on 1/29/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ViewController.h"

// static - variable is initialzed only one time, but not everytime, when action is called; const - not allowed to change
static const int localNumberMaxLenght = 7;
static const int areaCodeMaxLenght = 3;
static const int countryCodeMaxLenght = 3;

@interface ViewController ()

@end

@implementation ViewController


//SS: much more good and simple solutions of all tasks see at lesson 29. Homework-4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //SS: my testing of notifications (not connected with homework)
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificationDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    self.isHasAtSighn = NO;

    UIKIT_EXTERN NSString *const UITextFieldTextDidBeginEditingNotification;
    UIKIT_EXTERN NSString *const UITextFieldTextDidEndEditingNotification;
    UIKIT_EXTERN NSString *const UITextFieldTextDidChangeNotification;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications's methods

-(void) notificationDidBeginEditing: (NSNotification*) notification {
    NSLog(@"notifictionTextDidBeginEditing has come");
    //SS: DOESN'T work
    self.tFieldAge.background = [UIImage imageNamed:@"archEnemyLogo@2x.jpeg"];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSUInteger count = [self.allTextFileds count];
    NSUInteger currentIndex = [self.allTextFileds indexOfObject:textField];
    if (currentIndex < (count-1)) {
        id nextTF = [self.allTextFileds objectAtIndex:(currentIndex+1)];
        [nextTF becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"-------------New Input-----------");
    // path to extract and take what you have typed on current moment
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"textField.text before:%@. string is: %@.  new string is: %@", textField.text, string, newString);
//    NSLog(@"Range location: %ld. range lenght: %ld", range.location, range.length);

    //SS: section to send textField's content to Label (for Студент-level)
    NSUInteger currentIndex = [self.allTextFileds indexOfObject:textField];
    id object = [self.allLabels objectAtIndex:currentIndex];
    UILabel* linkedLabel = object;
    //SS: probably not optimal way, 'couse I did it not with one argument, but with "stringByAppendingString"
    linkedLabel.text = [textField.text stringByAppendingString:string];
    linkedLabel.backgroundColor = [UIColor yellowColor];
    
    //SS: for superman-level. Validation for email-field
    if ([textField isEqual:self.tFieldEmail]) {
        NSCharacterSet *invalidSymbols = [NSCharacterSet characterSetWithCharactersInString:@"/[*+]{}|'!#$%^&()=;:<>"];
        NSLog(@"string is: %@", string);

        NSArray* components = [string componentsSeparatedByCharactersInSet:invalidSymbols];
        if ([components count]>1) {
            NSLog(@"NOT VALID");
            return NO;
        }
        if (textField.text.length>20) {
            NSLog(@"You exeeded maximum lenght");
            return NO;
        }
        if ([string isEqualToString:@"@"]) {
            if (self.isHasAtSighn) {
                NSLog(@"it's forbidden to type more than one at-sighn");
                return NO;
            }
            self.isHasAtSighn = YES;
            return YES;
        }
    }
    
    //SS: How to block not-digit input for PhoneNumber and Age
    if ([textField isEqual:self.tFieldPhoneNumber] || [textField isEqual:self.tFieldAge] ) {
        NSLog(@"------------- checking not-digit input -----------");
        NSLog(@"textField.text before:%@", textField.text);

        NSCharacterSet * invalidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray * items = [string componentsSeparatedByCharactersInSet:invalidationSet];  // SIC ! string - it's only one last input (one pressing of key)
        if ([items count]>1) {
            NSLog(@"NOT VALID");
//            NSLog(@"two items : %@", items);
            return NO;
        }
    }

    //SS: sophisticted  path to make beauty for phone-number
    if ([textField isEqual:self.tFieldPhoneNumber]) {
        if (newString.length > localNumberMaxLenght+areaCodeMaxLenght+countryCodeMaxLenght) {
            NSLog(@"maximum lenght %d is exceeded", (localNumberMaxLenght+areaCodeMaxLenght+countryCodeMaxLenght));
            return NO;
        }
        
        //NSLog(@"2-nd checking of resultString is: %@", resultString);
        textField.text = [self makingBeautyForPhoneNumberFromString:newString];
        NSLog(@"textField.text after:%@", textField.text);
        
        //SS: we assign NO, becouse we directly changed textFiled's content, we don't need changing by delegate
        return NO;
    } else {
        NSLog(@"tFieldPhoneNumber?: NO");
        return YES;
    }
    
    

}

-(NSString*) makingBeautyForPhoneNumberFromString:(NSString *) sourceString {
    NSLog(@"------------- making beauty -----------");
    NSCharacterSet * invalidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    //but we get dirty string, like this, so we need to make purge
    // +XX (XXX) XXX-XXXX will be converted to XXXXXXXXXXXX
    //NSLog(@"dirty new string is: %@", newString);
    NSArray * validComponents = [sourceString componentsSeparatedByCharactersInSet:invalidationSet];
    sourceString = [validComponents componentsJoinedByString:@""];
    //NSLog(@"purged new string is: %@", newString);
    
    //alloc init empty resultString
    NSMutableString* resultString = [NSMutableString string];
    //local number
    NSInteger localNumberLenght = MIN([sourceString length], localNumberMaxLenght);
    if (localNumberLenght > 0) {
        NSString* number = [sourceString substringFromIndex:(int)[sourceString length] - localNumberLenght];
        [resultString appendString:number];
        NSLog(@"number is: %@", number);
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

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSUInteger currentIndex = [self.allTextFileds indexOfObject:textField];
    id object = [self.allLabels objectAtIndex:currentIndex];
    UILabel* linkedLabel = object;
    linkedLabel.text = nil;
    return YES;
}


- (IBAction)extractButton:(id)sender {
    NSLog(@"extraction of textField.text: %@", self.tFieldPhoneNumber.text);
}
@end

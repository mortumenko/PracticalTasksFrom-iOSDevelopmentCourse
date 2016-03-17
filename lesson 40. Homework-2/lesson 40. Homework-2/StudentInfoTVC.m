//
//  StudentInfoTVC.m
//  lesson 40. Homework-2
//
//  Created by Admin on 2/5/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "StudentInfoTVC.h"

@interface StudentInfoTVC ()

@end

@implementation StudentInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//SS: Ученик-level
    //assigning delegate for all textfields
    for (UITextField* object in self.allTextFileds) {
        object.delegate = self;
    }
    
    Student* student1 = [[Student alloc] init];
    self.explicitStudent = student1;
    
//SS: Мастер-level.6
    Student* student2 = [[Student alloc] init];
    Student* student3 = [[Student alloc] init];
    Student* student4 = [[Student alloc] init];
    Student* student5 = [[Student alloc] init];
    Student* student6 = [[Student alloc] init];
    Student* student7 = [[Student alloc] init];
    Student* student8 = [[Student alloc] init];
    Student* student9 = [[Student alloc] init];
    Student* student10 = [[Student alloc] init];

    NSArray* studentsArray = [[NSArray alloc] initWithObjects:student1, student2, student3, student4, student5, nil];
//SS: Мастер-level.7
    student1.friend = student2;
    student2.friend = student3;
    student3.friend = student4;
    student4.friend = student5;
    student5.friend = student1;
    


    //show random student  info
    self.firstNameTField.text = student1.firstName;
    self.lastNameTField.text = student1.lastName;
    self.dateOfBirthTField.text = student1.dateOfBirthAsString;
    self.genderSegmContr.selectedSegmentIndex = student1.genderIsMale;
    self.gradeTFiled.text = [NSString stringWithFormat:@"%d", student1.grade];
    
//SS: Студент-level.4 OBSERVING
    [student1 addObserver:self
               forKeyPath:@"firstName"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    [student1 addObserver:self
               forKeyPath:@"lastName"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    [student1 addObserver:self
               forKeyPath:@"dateOfBirth"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    [student1 addObserver:self
               forKeyPath:@"genderIsMale"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    [student1 addObserver:self
               forKeyPath:@"grade"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
//SS: Мастер-level.8, 9
    [student2 setValue:@"St. Mykola" forKeyPath:@"friend.firstName"]; //for student3
    [student2 setValue:@"St. Pilyp" forKeyPath:@"friend.friend.firstName"]; //for student4
    [student2 setValue:@"St. Ivan" forKeyPath:@"friend.friend.friend.firstName"]; //for student5
    [student2 setValue:@"St. John" forKeyPath:@"friend.friend.friend.friend.firstName"]; //for student1
    [student1 setValue:@"St. Odarka" forKeyPath:@"friend.firstName"]; //for student2
    /*
    NSLog(@"All students");
    for (Student* currentStudent in studentsArray) {
        NSLog(@"%@, %@, gender: %d, %@, grade: %d", currentStudent.firstName, currentStudent.lastName, currentStudent.genderIsMale, currentStudent.dateOfBirth, currentStudent.grade);
    }
    */
    //show linked-student  info
    self.firstNameTField.text = student1.firstName;
    self.lastNameTField.text = student1.lastName;
    self.dateOfBirthTField.text = student1.dateOfBirthAsString;
    self.genderSegmContr.selectedSegmentIndex = student1.genderIsMale;
    self.gradeTFiled.text = [NSString stringWithFormat:@"%d", student1.grade];
 
    
//SS: superman-level. KVO-collections operators (DONE !)
    //SS: superman-level.10
    NSArray* allStudentsArray = [[NSArray alloc] initWithObjects:student1, student2, student3, student4, student5, student5, student6, student7, student8, student9, student10, nil];
    //SS: superman-level.11 (extract all firstNames to array)
    NSArray* allFirstNames = [allStudentsArray valueForKeyPath:@"@distinctUnionOfObjects.firstName"];
    NSLog(@"allFirstNames: %@", allFirstNames);
    //SS: superman-level.12
    NSDate* earliestBirthday = [allStudentsArray valueForKeyPath:@"@min.dateOfBirth"];
    NSDate* lastBirthday = [allStudentsArray valueForKeyPath:@"@max.dateOfBirth"];
    NSLog(@"earliestBirthday and lastBirthday: %@ and %@", earliestBirthday, lastBirthday);
    
    //SS: superman-level.13
    NSNumber *gradeSum = [allStudentsArray valueForKeyPath:@"@sum.grade"];
    NSNumber * gradeAverage = [allStudentsArray valueForKeyPath:@"@avg.grade"];
    NSNumber *gradeMax = [allStudentsArray valueForKeyPath:@"@max.grade"];
    NSNumber *gradeMin = [allStudentsArray valueForKeyPath:@"@min.grade"];
    NSLog(@"sum of grade is: %@. \n average grade is: %@", gradeSum, gradeAverage);
    NSLog(@"maximum grade is: %@. \n minimum grade is: %@", gradeMax, gradeMin);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) dealloc {
    //SS: Студент-level.4 OBSERVING
    [self.explicitStudent removeObserver:self forKeyPath:@"firstName"];
    [self.explicitStudent removeObserver:self forKeyPath:@"lastName"];
    [self.explicitStudent removeObserver:self forKeyPath:@"dateOfBirth"];
    [self.explicitStudent removeObserver:self forKeyPath:@"genderIsMale"];
    [self.explicitStudent removeObserver:self forKeyPath:@"grade"];
}
//SS: Студент-level.4 OBSERVING. This command works for all keys!
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"observeValueForKeyPath is done. Key: %@ is changed", keyPath);
    //full info for event observer is called:
//    NSLog(@"observeValueForKeyPath is done\n Key: %@ is changed. changeDict: %@", keyPath, change);
    id value = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"new value is: %@", value);
}



#pragma mark - UITextFieldDelegate
//SS: Ученик-level
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@" %@ textFieldDidEndEditing", textField.placeholder);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy"];
    if ([textField isEqual:self.firstNameTField]) {
        self.explicitStudent.firstName = textField.text;
    } else if ([textField isEqual:self.lastNameTField]) {
        self.explicitStudent.lastName = textField.text;
    } else if ([textField isEqual:self.gradeTFiled]) {
        self.explicitStudent.grade = [textField.text intValue];
    }  else if ([textField isEqual:self.dateOfBirthTField]) {
        NSDate* date =  [[formatter dateFromString:textField.text] dateByAddingTimeInterval:(3600*3+1)];
        self.explicitStudent.dateOfBirth = date;
    }
    NSLog(@"student is changed: \nFirst name: %@, last name: %@, gender: %d, date of birth: %@, grade: %d", self.explicitStudent.firstName, self.explicitStudent.lastName, self.explicitStudent.genderIsMale, self.explicitStudent.dateOfBirth, self.explicitStudent.grade);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions
- (IBAction)genderChangedAction:(UISegmentedControl *)sender {
    self.explicitStudent.genderIsMale = self.genderSegmContr.selectedSegmentIndex;
}
//SS: Студент-level.5
- (IBAction)clearAllFileds:(id)sender {
    //SS: turn to nil all student's properties
    [self.explicitStudent changeFirstNameThroughIvarToValue:nil];
    [self.explicitStudent changeLastNameThroughIvarToValue:nil];
    [self.explicitStudent changeDateOfBirthThroughIvarToValue:nil];
    [self.explicitStudent changeGenderIsMaleThroughIvarToValue:2];
    [self.explicitStudent changeGradeThroughIvarToValue:0];
    
    //SS: turn to nil all text fields
    self.firstNameTField.text = nil;
    self.lastNameTField.text = nil;
    self.dateOfBirthTField.text = nil;
    self.genderSegmContr.selectedSegmentIndex = 2;
    self.gradeTFiled.text = nil;
}

@end

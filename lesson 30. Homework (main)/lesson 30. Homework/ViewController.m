//
//  ViewController.m
//  lesson 30. Homework
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "ColourCellsTableVC.h"
#import "AdditionalClass.h"
#import "Student.h"
#import "GradeGroups.h"


typedef enum {
    gradeIs2,
    gradeIs3,
    gradeIs4,
    gradeIs5,
    colorSection
} gradeGroups;


@interface ViewController ()

@property (strong, nonatomic) GradeGroups* groupByGrade2;
@property (strong, nonatomic) GradeGroups* groupByGrade3;
@property (strong, nonatomic) GradeGroups* groupByGrade4;
@property (strong, nonatomic) GradeGroups* groupByGrade5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad of VC-class is executed");
    // Do any additional setup after loading the view, typically from a nib.
    UIEdgeInsets insets = UIEdgeInsetsMake(50, 0, 50, 0);
    self.tableProp.contentInset = insets;
    self.tableProp.scrollIndicatorInsets = insets;
    //SS: student-level
    
    self.manyObjectsArray = [[NSMutableArray alloc] init];
    for (int i=1; i<11; i++) {
        AdditionalClass * instance = [[AdditionalClass alloc] initWithNumber:i];
        [self.manyObjectsArray addObject:instance];
    }
    NSLog(@"DONE! %lu objects of AdditionalClass are created", (unsigned long)[self.manyObjectsArray count]);
    
    //DOESN'T work
    /*
    self.navigationItem.title = @"students lists";

    UIBarButtonItem * BBItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                             target:self
                                                                             action:@selector(nothingAction)];
    BBItem.title=@"AA";
    self.navigationItem.rightBarButtonItem = BBItem;
    */
    self.manyStudentsArray = [[NSMutableArray alloc] init];
    for (int item; item<=30; item++) {
        Student* student = [[Student alloc] init];
        [self.manyStudentsArray addObject:student];
    }
    NSLog(@"DONE! %lu objects of Student-class are created", (unsigned long)[self.manyStudentsArray count]);
    
    //SS: Супермен-level.14-15
    self.groupByGrade2 = [[GradeGroups alloc] init];
    self.groupByGrade3 = [[GradeGroups alloc] init];
    self.groupByGrade4 = [[GradeGroups alloc] init];
    self.groupByGrade5 = [[GradeGroups alloc] init];
    
    //NSMutableArray* grade2Array = [[NSMutableArray alloc] init];
    self.groupByGrade2.students = [[NSMutableArray alloc] init]; //path 1 to add student (without arrays-helpers)
    NSMutableArray* grade3Array = [[NSMutableArray alloc] init]; //path 2 to add student (with arrays-helpers)
    NSMutableArray* grade4Array = [[NSMutableArray alloc] init];
    NSMutableArray* grade5Array = [[NSMutableArray alloc] init];

//SS: bad way (not MVC)
//    self.grade3Students = [[NSMutableArray alloc] init];
//    self.grade4Students = [[NSMutableArray alloc] init];
//    self.grade5Students = [[NSMutableArray alloc] init];

    for (Student* student in self.manyStudentsArray) {
        if (student.grade==2) {
//SS: bad way (not MVC)
//            [self.grade2Students addObject:student];
//            [grade2Array addObject:student];
//SS: Alternative way to add student
            [self.groupByGrade2.students addObject:student];  //path 1 to add student
        } else if (student.grade==3) {
            [grade3Array addObject:student];  //path 2 to add student (with arrays-helpers)
        } else if (student.grade==4) {
            [grade4Array addObject:student];
        } else {
            [grade5Array addObject:student];
        }
    }
    
    self.groupByGrade3.students = grade3Array; //path 2 to add student (with arrays-helpers)
    self.groupByGrade4.students = grade4Array;
    self.groupByGrade5.students = grade5Array;

    //SS: Мастер-level.13
    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc ] initWithKey:@"nameSynthesised" ascending:YES];
    NSArray* descriptorsArray = @[descriptor];
    [self.manyStudentsArray sortUsingDescriptors:descriptorsArray]; //SS: brilliant method ! (only for NSMutableArray)
    
    //SS: Супермен-level.17
    [self.groupByGrade2.students sortUsingDescriptors:descriptorsArray];
    //SS: bad way (not MVC)
    //    [self.grade2Students sortUsingDescriptors:descriptorsArray];
    [self.groupByGrade3.students sortUsingDescriptors:descriptorsArray];
    [self.groupByGrade4.students sortUsingDescriptors:descriptorsArray];
    [self.groupByGrade5.students sortUsingDescriptors:descriptorsArray];

    NSLog(@"Checking. Total amount of items in all groups is: %ld", (unsigned long) ([self.groupByGrade2.students count]+[self.groupByGrade3.students count]+[self.groupByGrade4.students count]+[self.groupByGrade5.students count]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return (4+1); //SS: 4 - for students, 1 - for colors
}
//SS: Супермен-level.16
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    static NSString* title;
    if (section==gradeIs2) {
        title=@"grade 2";
    } else if (section==gradeIs3) {
        title=@"grade 3";
    } else if (section==gradeIs4) {
        title=@"grade 4";
    } else if (section==gradeIs5) {
        title=@"grade 5";
    } else if (section==colorSection) { //SS: Mission Impossible-level.19
        title=@"section for colors";
    }
    return title;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger counter;
    //counter = [self.manyObjectsArray count]; //for AdditionalCLass content
    //counter = [self.manyStudentsArray count]; //for StudentClass content. //SS: Мастер-level
    if (section==gradeIs2) {
        counter=[self.groupByGrade2.students count];
        //SS: bad way (not MVC)
//        counter=[self.grade2Students count];
    } else if (section==gradeIs3) {
        counter=[self.groupByGrade3.students count];
    } else if (section==gradeIs4) {
        counter=[self.groupByGrade4.students count];
    } else if (section==gradeIs5) {
        counter=[self.groupByGrade5.students count];
    } else if (section==colorSection) { //SS: Mission Impossible-level.19
        counter=10;
    }
//    NSLog(@"DONE numberOfRowsInSection %ld. value is %lu", section, (unsigned long)counter);
    return counter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//SS: student-level
   /*
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UIColor* currentColor = [[self.manyObjectsArray objectAtIndex:indexPath.row] colorOfObject];
    NSString* currentName = [[self.manyObjectsArray objectAtIndex:indexPath.row] nameOfObject];
    cell.backgroundColor = currentColor;
    cell.textLabel.text = currentName;
    //NSLog(@"cell with name [%@] is created", currentName);
*/
    
//    static NSString* cellIdentifier = @"cell";

    //SS: Супермен-level.18, Mission Impossible-level.19,20
    if (indexPath.section < colorSection) {
        NSString* fullName;
        int grade;
        if (indexPath.section==gradeIs2) {
            fullName = [[self.groupByGrade2.students objectAtIndex:indexPath.row] nameSynthesised];
            grade = [[self.groupByGrade2.students objectAtIndex:indexPath.row] grade];
            //SS: bad way (not MVC)
//            fullName = [[self.grade2Students objectAtIndex:indexPath.row] nameSynthesised];
//            grade = [[self.grade2Students objectAtIndex:indexPath.row] grade];
        } else if (indexPath.section==gradeIs3) {
            fullName = [[self.groupByGrade3.students objectAtIndex:indexPath.row] nameSynthesised];
            grade = [[self.groupByGrade3.students objectAtIndex:indexPath.row] grade];
        } else if (indexPath.section==gradeIs4) {
            fullName = [[self.groupByGrade4.students objectAtIndex:indexPath.row] nameSynthesised];
            grade = [[self.groupByGrade4.students objectAtIndex:indexPath.row] grade];
        } else if (indexPath.section==gradeIs5) {
            fullName = [[self.groupByGrade5.students objectAtIndex:indexPath.row] nameSynthesised];
            grade = [[self.groupByGrade5.students objectAtIndex:indexPath.row] grade];
        }
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.textLabel.text = fullName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", grade];
        if (grade < 4 ) {
            cell.textLabel.textColor = [UIColor redColor];
        }
        return cell;
    } else {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UIColor* currentColor = [[self.manyObjectsArray objectAtIndex:indexPath.row] colorOfObject];
        NSString* currentName = [[self.manyObjectsArray objectAtIndex:indexPath.row] nameOfObject];
        cell.backgroundColor = currentColor;
        cell.textLabel.text = currentName;
        return cell;
    }
    
//SS: Мастер-level.10-12
//    NSString* fullName = [[self.manyStudentsArray objectAtIndex:indexPath.row] nameSynthesised];
//    int grade = [[self.manyStudentsArray objectAtIndex:indexPath.row] grade];
}

#pragma mark - Actions

-(void) nothingAction {
    NSLog (@"nothingAction is done");
}

# pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog (@"delegateAction 'didDeselectRowAtIndexPath' is done");
}

@end

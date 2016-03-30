//
//  UserDetails.m
//  lesson41-CoreDataPart1Basic
//
//  Created by Admin on 3/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "UserDetails.h"
#import "UsersMO.h"
typedef enum {
    infoItemFirstName,
    infoItemLastName,
    infoItemMotherLand,
    infoItemEmail
} infoItemsEnum;

typedef enum {
    modeJustPersonal = 1,
    modeOnlyEnrolled = 2,
    modeOnlyToTeach = 3,
    modeBoth = 4
} modeSectionToDisplay;

@interface UserDetails ()
@property (strong, nonatomic) NSDictionary* flagNamesForCountries;
@property (strong, nonatomic) NSArray* coursesEnrolled;
@property (assign, nonatomic) NSUInteger modeToDisplay;

@end

@implementation UserDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"details for [%@ %@]", self.userForParsing.firstName, self.userForParsing.lastName];
//creating array for courses that enrolled
    if (self.userForParsing.courseEnroled.count != 0) {
        self.coursesEnrolled = [self.userForParsing.courseEnroled allObjects];
        NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
        [self.coursesEnrolled sortedArrayUsingDescriptors:@[descriptor]];
    }
    if (self.userForParsing.courseEnroled.count !=0 && self.userForParsing.courseToTeach) {
        self.modeToDisplay = modeBoth;
    } else if (self.userForParsing.courseEnroled.count !=0) {
        self.modeToDisplay = modeOnlyEnrolled;
    } else if (self.userForParsing.courseToTeach) {
        self.modeToDisplay = modeOnlyToTeach;
    }

//SS: inset correct name of with with corresponding flag
    self.flagNamesForCountries = @{@"Germany":@"flag-germany.png",
                                   @"Ukraine":@"flag-ukraine.png",
                                   @"Poland":@"flag-poland.png",
                                   @"Chech-Rep":@"flag-czech-republic.png",
                                   @"China":@"flag-china.png",
                                   @"Japan":@"flag-japan.png",
                                   @"USA":@"flag-usa.png",
                                   @"Malasia":@"",
                                   @"France":@"flag-france.png",
                                   @"Spaine":@"",
                                   @"Georgia":@"flag-georgia.png"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Additional


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number;
    
    if (section == 0) {
        number = 4;
    } else if (section == 1 && self.modeToDisplay == modeOnlyEnrolled) {
        number = [self.coursesEnrolled count];
    } else if (section == 1 && self.modeToDisplay == modeOnlyToTeach) {
        number = 1;
    } else if (section == 1 && self.modeToDisplay == modeBoth) {
        number = [self.coursesEnrolled count];
    } else if (section == 2) {
        number = 1;
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger number = 1;
    if (self.modeToDisplay == modeOnlyEnrolled || self.modeToDisplay == modeOnlyToTeach) {
        number = 2;
    } else if (self.modeToDisplay == modeBoth) {
        number = 3;
    }
    return number;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title;
    if (section == 0) {
        title = @"personal info:";
    } else if (section == 1 && self.modeToDisplay == modeOnlyEnrolled) {
        title = @"enrolled for courses:";
    } else if (section == 1 && self.modeToDisplay == modeBoth) {
        title = @"enrolled for courses:";
    }
    else if (section == 1 && self.modeToDisplay == modeOnlyToTeach) {
        title = @"teacher for course:";
    }
    else if (section == 2) {
        title = @"teacher for course:";
    }
    return title;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString* title;

    if (section == 1 && self.modeToDisplay == (modeOnlyEnrolled | modeBoth)) {
        title = [NSString stringWithFormat: @"Number of courses: %lu", self.coursesEnrolled.count];
    }
    return title;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* studentCellIdentifier = @"UserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentCellIdentifier];
    }
    
    if (indexPath.section == 0) {
        [self configureCellForPersonalInfoSection:cell atIndexPath:indexPath];
    } else if (indexPath.section == 1 && self.modeToDisplay == modeOnlyEnrolled) {
        [self configureCellForEnrolledCoursesSection:cell atIndexPath:indexPath];
    } else if (indexPath.section == 1 && self.modeToDisplay == modeOnlyToTeach) {
        [self configureCellForCoursesToTeachSection:cell atIndexPath:indexPath];
    } else if (indexPath.section == 1 && self.modeToDisplay == modeBoth) {
        [self configureCellForEnrolledCoursesSection:cell atIndexPath:indexPath];
    } else if (indexPath.section == 2) {
        [self configureCellForCoursesToTeachSection:cell atIndexPath:indexPath];
    }
   
    return cell;
}

- (void)configureCellForPersonalInfoSection:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UsersMO *displayedUser = self.userForParsing;
    cell.detailTextLabel.text = nil;
    
    float cellHeight = cell.contentView.frame.size.height;
    float height = 30;
    float offset = (cellHeight-height)/2;
    
    UILabel* label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    label.frame = CGRectMake(20, offset, 150, height);
    label.font = [UIFont fontWithName:@"Arial" size:14];
    
    UITextField* textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor greenColor];
    textField.frame = CGRectMake(200, offset, 150, height);
    textField.font = [UIFont fontWithName:@"Arial" size:14];
    textField.delegate = self;
    
    
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:textField];
    
    NSInteger number = indexPath.row;
    switch(number) {
        case infoItemFirstName:
            label.text = @"First name:";
            textField.text = [NSString stringWithFormat:@"%@", displayedUser.firstName];
            cell.contentView.tag = infoItemFirstName;
            break;
        case infoItemLastName:
            label.text = @"Last name:";
            textField.text = [NSString stringWithFormat:@"%@", displayedUser.lastName];
            cell.contentView.tag = infoItemLastName;
            break;
        case infoItemMotherLand:
            label.text = @"Motherland:";
            textField.text = [NSString stringWithFormat:@"%@", displayedUser.motherLand];
            cell.contentView.tag = infoItemMotherLand;
            break;
        case infoItemEmail:
            label.text = @"E-mail:";
            textField.text = [NSString stringWithFormat:@"%@", displayedUser.email];
            cell.contentView.tag = infoItemEmail;
            break;
        default:
            return;
    }
    //SS: I couldn't insert if into <case infoItemMotherLand>
    if (number == infoItemMotherLand) {
        UIImage* image = [self flagForCountryName:displayedUser.motherLand];
        UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(textField.frame.size.width-image.size.width, 5, image.size.width, image.size.height);
        [textField addSubview:imageView];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([textField.text  isEqual: @"(null)"]) {
        textField.clearsOnBeginEditing = YES;
    }
}
- (void)configureCellForEnrolledCoursesSection:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CoursesMO* course = [self.coursesEnrolled objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.nameOfCourse];
}

- (void)configureCellForCoursesToTeachSection:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.userForParsing.courseToTeach.nameOfCourse];
}

-(UIImage*) flagForCountryName: (NSString*) name {
    NSString*fileName = [self.flagNamesForCountries valueForKey:name];
    return [UIImage imageNamed:fileName];
}
-(UIImageView*) flagForCountry {
    NSString*fileName = [self.flagNamesForCountries valueForKey:self.userForParsing.motherLand];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:fileName]];
    return imageView;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger aTag = textField.superview.tag;
    NSString* keyForEditing;
    switch(aTag) {
        case infoItemFirstName:
            keyForEditing = @"firstName";
            break;
        case infoItemLastName:
            keyForEditing = @"lastName";
            break;
        case infoItemMotherLand:
            keyForEditing = @"motherLand";
            break;
        case infoItemEmail:
            keyForEditing = @"email";
            break;
        default:
            return;
    }
    [self.userForParsing setValue:textField.text forKey:keyForEditing];
    [[ManagerForCoreData sharedManager] saveContext];
    NSLog(@"textFieldDidEndEditing. new text: %@", textField.text);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    float height = 0;
    if (section == 1) {
        height = 20;
    }
    return height;
}
@end

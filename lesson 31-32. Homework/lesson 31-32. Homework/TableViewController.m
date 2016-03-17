//
//  TableViewController.m
//  lesson 31-32. Homework
//
//  Created by Admin on 2/9/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "TableViewController.h"
#import "Countries.h"
#import "Unions.h"

typedef enum {
    TransAtlanticUnion,
    secondWolrd,
    thirdWorld
} unionTypesEnum;

@interface TableViewController ()
@property (strong, nonatomic) Unions * unionTA;
@property (strong, nonatomic) Unions * union2ndWorld;
@property (strong, nonatomic) Unions * union3rdWorld;
@property (strong, nonatomic) NSArray* unionsArray;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Студент-level
    
    self.navigationItem.title = @"title for list";
    /*
    UIBarButtonItem * editModeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(changeEditMode)];
    self.navigationItem.rightBarButtonItem = editModeButton;
    */
    //SS: But we don't need to do this, because here is default-delivered code for this issue bellow. But it (default) is realisation without any additional actions
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Супермен-level
    
    UIBarButtonItem * addUnionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                       target:self
                                                                                       action:@selector(addUnion)];
    
    /*
    UIBarButtonItem * addCountryButton = [[UIBarButtonItem alloc] initWithTitle:@"add country"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(addCountryIntoUnionTA)];*/
    self.navigationItem.leftBarButtonItem = addUnionButton;
    
    //Creating data
    self.unionTA = [[Unions alloc] init];
    self.union2ndWorld = [[Unions alloc] init];
    self.union3rdWorld = [[Unions alloc] init];
    
    self.unionTA.countries = [[NSMutableArray alloc] init];
    self.union2ndWorld.countries = [[NSMutableArray alloc] init];
    self.union3rdWorld.countries = [[NSMutableArray alloc] init];

    for (int item=0; item<20; item++) {
        Countries* country = [[Countries alloc] init];
        //NSLog(@"%@ demR: %.2f busFrRate: %d", country.countryName, country.democracyRate, country.businessFreedomRate);
        if (country.democracyRate>4.f && country.businessFreedomRate<80) {
            [self.unionTA.countries addObject:country];
        } else if (country.democracyRate>2.f && country.businessFreedomRate<150) {
            [self.union2ndWorld.countries addObject:country];
        } else {
            [self.union3rdWorld.countries addObject:country];
        }
    }
    self.unionsArray = [[NSArray alloc] initWithObjects:self.unionTA, self.union2ndWorld, self.union3rdWorld, nil];
    //NSLog(@"unionsArray count: %lu", (unsigned long)[self.unionsArray count]);
    NSLog(@"------------ it was initial data state --------------");
    NSLog(@"unionTA members amount: %lu", (unsigned long)[self.unionTA.countries count]);
    NSLog(@"union2ndWolrd members amount: %lu", (unsigned long)[self.union2ndWorld.countries count]);
    NSLog(@"union3rdWolrd members amount: %lu", (unsigned long)[self.union3rdWorld.countries count]);
    NSLog(@"-----------------------------------------------------");

//SS: sort array
    //unsuccesful experiment with second descriptor based on comparator
    //start
    NSComparisonResult(^strangeComparing)(id obj1, id obj2);
    strangeComparing = ^(id obj1, id obj2) {
        Countries* c1= obj1;
        Countries* c2 = obj2;
        return [c1.countryName compare:c2.countryName];
    };
    NSSortDescriptor* descriptor2 = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES comparator:strangeComparing];

    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"democracyRate" ascending:NO];
    //end
    
    NSArray* array = @[descriptor];
    [self.unionTA.countries sortUsingDescriptors:array];
    [self.union2ndWorld.countries sortUsingDescriptors:array];
    [self.union3rdWorld.countries sortUsingDescriptors:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.unionsArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* name;
    if (section == TransAtlanticUnion) {
        name = @"Trans Atlantic Union's countries";
    } else if (section == secondWolrd) {
        name = @"countries of 'second' world";
    } else if (section == thirdWorld) {
        name = @"countries of 'third' world";
    } else {
        name = [NSString stringWithFormat:@"new union # %ld", section];
    }
    return name;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger numberOfcountries;
    //SS: +1 - it's for empty row for adding country
    if (section == TransAtlanticUnion) {
        numberOfcountries = [self.unionTA.countries count]+1;
    } else if (section == secondWolrd) {
        numberOfcountries = [self.union2ndWorld.countries count]+1;
    } else if (section == thirdWorld) {
        numberOfcountries = [self.union3rdWorld.countries count]+1;
    } else {
        Unions* newUnion = [self.unionsArray objectAtIndex:section];
        numberOfcountries = [newUnion.countries count]+1;
    }
    return numberOfcountries;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSUInteger numberOfcountries  = [self countItemsInUnionWithNumber:indexPath.section];
    if (indexPath.row == numberOfcountries) {
        cell.textLabel.text = @"add new country for this union";
        cell.textLabel.textAlignment = NSTextAlignmentRight; //SS: DOESN'T work
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    
    NSString* name;
    float demRate;
//    int bussFreedRate;
    if (indexPath.section == TransAtlanticUnion) {
        name = [[self.unionTA.countries objectAtIndex:indexPath.row] countryName];
        demRate = [[self.unionTA.countries objectAtIndex:indexPath.row] democracyRate];
//        bussFreedRate = [[self.unionEU.countries objectAtIndex:indexPath.row] businessFreedomRate];
    } else if (indexPath.section == secondWolrd) {
        name = [[self.union2ndWorld.countries objectAtIndex:indexPath.row] countryName];
        demRate = [[self.union2ndWorld.countries objectAtIndex:indexPath.row] democracyRate];
//        bussFreedRate = [[self.union2ndWolrd.countries objectAtIndex:indexPath.row] businessFreedomRate];
    } else if (indexPath.section == thirdWorld) {
        name = [[self.union3rdWorld.countries objectAtIndex:indexPath.row] countryName];
        demRate = [[self.union3rdWorld.countries objectAtIndex:indexPath.row] democracyRate];
        //        bussFreedRate = [[self.union3rdWolrd.countries objectAtIndex:indexPath.row] businessFreedomRate];
    } else {
        Unions * currentUnion = [self.unionsArray objectAtIndex:indexPath.section];
        name = [[currentUnion.countries objectAtIndex:indexPath.row] countryName];
        demRate = [[currentUnion.countries objectAtIndex:indexPath.row] democracyRate];
//        bussFreedRate = [[self.union3rdWolrd.countries objectAtIndex:indexPath.row] businessFreedomRate];
    }
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"democr.Rate: %.2f", demRate];
    return cell;
}

//Мастер-level
//CHAPTER II - editing, deleting
//SS: conditional permission. Is done just AFTER you press Edit-button (changed self.tableView.editing = YES), BEFORE you tried to delete (edit). Is called  for EVERY row (one by one).
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == TransAtlanticUnion) {
        return NO;
    }
    return YES;
}

//SS: Delegate. Called, after you pressed delete-confirmation. Place for make some manipulations whis data, 'cause it's delegate's method. It's requaired! You must change table or array who delivers items.
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Unions * currentUnion =  [self.unionsArray objectAtIndex:indexPath.section];
        [currentUnion.countries removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates]; //method-helper-1
        //SS: after this methods mistake occures, if it not supported with data-manipulations. I think this methods calls [self.tableview reloadData]
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates]; //method-helper-2
        //[self.tableView reloadData]; //it's not requaired. And it's bad, because after this method animation becomes spoiled
        //SS: also it's not allowed remove row from datasource and make reloadData
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        id country = [[Countries alloc] init];
        Unions* extendedUnion = [self.unionsArray objectAtIndex:indexPath.section];
        [extendedUnion.countries addObject:country];
        NSArray* array = [[NSArray alloc] initWithObjects:indexPath, nil];
        [self.tableView beginUpdates]; //method-helper-1
        [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates]; //method-helper-2


    }
}


//Студент-level
//CHAPTER I - moving, rearranging, re-odering

//SS: conditional permission for certain row. Is done just AFTER you press Edit-button (changed self.tableView.editing = YES), BEFORE you tried to drag. Is called  for EVERY row (one by one).
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==thirdWorld) {
        return NO;
    }
    //SS: forbiding for add-button-row
    NSUInteger numberOfcountries  = [self countItemsInUnionWithNumber:indexPath.section];
    if (indexPath.row == numberOfcountries) {
        return NO;
    }
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// VERY IMPORTENT !!! conditional re-odering. Is called after you target a victim (row for  replacing)
//SS: cheking and denying replacing add-button-row
-(NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSUInteger numberOfcountries  = [self countItemsInUnionWithNumber:proposedDestinationIndexPath.section];
    if (proposedDestinationIndexPath.row == numberOfcountries) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

//SS: Delegate. Called, after you tried to drag. Place for make some manipulations whis data, 'cause it's delegate's method. It's usefull, when you move item from one section to another and if you must change table or array who will own this item after moving. if you don't need to change data in you arrays and tables you can miss it.
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    //SS: moving data
    Unions* sourceUnion = [self.unionsArray objectAtIndex:fromIndexPath.section];
    Countries* movedCountry = [sourceUnion.countries objectAtIndex:fromIndexPath.row];
    [sourceUnion.countries removeObject:movedCountry];
    
    Unions* destinationUnion = [self.unionsArray objectAtIndex:toIndexPath.section];
    [destinationUnion.countries insertObject:movedCountry atIndex:toIndexPath.row];
    
    //SS: checking and visualisation
    NSLog(@"moveRowAtIndexPath is done. IndexPath: %ld-%ld", (long)fromIndexPath.section, (long)fromIndexPath.row);
    NSLog(@"unionTA members count: %lu", (unsigned long)[self.unionTA.countries count]);
    NSLog(@"union2ndWolrd members count: %lu", (unsigned long)[self.union2ndWorld.countries count]);
    NSLog(@"union3rdWolrd members count: %lu", (unsigned long)[self.union3rdWorld.countries count]);
    if (self.unionsArray.count > 3) {
        NSInteger number = [self.unionsArray count];
        for (int item = 3; item < number; item++) {
            Unions* currentUnion = [self.unionsArray objectAtIndex:item];
            NSLog(@"newUnion #%d members count: %lu", item, [currentUnion.countries count]);
        }
    }
    //[self.tableView reloadData]; //it's not requaired
}



#pragma mark - Actions
//Супермен-level
//SS: it for One static section. Isn't active now
-(void) addCountryIntoUnionTA {
    id country = [[Countries alloc] init];
    Unions* extendedUnion = [self.unionsArray objectAtIndex:0]; //SS: why does it work ? Because it's not creation of new union, it's declaration and assigning name to EXISTING union at index...
    [extendedUnion.countries addObject:country];
    [self.tableView reloadData];
}

-(NSInteger) countItemsInUnionWithNumber: (NSInteger) number {
    //SS: !!! cool KVC-method
    NSNumber* countAsNSNumber = [[self.unionsArray objectAtIndex:number] valueForKeyPath:@"countries.@count"];
    NSUInteger numberOfcountries  = [countAsNSNumber integerValue];
    return numberOfcountries;
}

-(void) addUnion {
     NSInteger newSectionIndex = [self.unionsArray count];
     Unions* newUnion = [[Unions alloc] init];
     int rand = arc4random_uniform(4)+1;
     newUnion.countries = [[NSMutableArray alloc] init];
     for (int item=0; item < rand; item++) {
         Countries* newCountry = [[Countries alloc] init];
         [newUnion.countries addObject:newCountry];
     }
     NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:self.unionsArray];
     [tempArray addObject:newUnion];
     self.unionsArray = tempArray;
     //[self.tableView reloadData]; for without animation-mode. With animation-mode: strings bellow:
     
     [self.tableView beginUpdates];
     NSIndexSet* newSectionIndexSet = [NSIndexSet indexSetWithIndex:newSectionIndex];
     [self.tableView insertSections:newSectionIndexSet withRowAnimation:UITableViewRowAnimationTop];
     [self.tableView endUpdates];
/*
     UITableViewRowAnimationFade,
     UITableViewRowAnimationRight,
     UITableViewRowAnimationLeft,
     UITableViewRowAnimationTop,
     UITableViewRowAnimationBottom,
     UITableViewRowAnimationNone,
     UITableViewRowAnimationMiddle,
*/
     NSLog(@"addUnion is DONE");
}


//Студент-level
//SS: Isn't active now
-(void) changeEditMode {
    BOOL currentState = self.tableView.editing;
//reverse the edit-state
    if (self.tableView.editing) {
        self.tableView.editing = NO;
    } else {
        self.tableView.editing = YES;
    }
//reverse the right system barButton style
    UIBarButtonSystemItem style = UIBarButtonSystemItemDone;
//change to "start edit icon" only if currentState was "edit is allowed" before pressing
    if (currentState) {
        style = UIBarButtonSystemItemEdit;
    }
    UIBarButtonItem * freshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style
                                                                                  target:self
                                                                                  action:@selector(changeEditMode)];
    self.navigationItem.rightBarButtonItem = freshButton;
}

#pragma mark - UITableViewDelegate
//SS: Edit- STYLES
//SS: assigning UITableViewCellEditingStyleInsert to add-cell (last and yellow)
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger numberOfcountries  = [self countItemsInUnionWithNumber:indexPath.section];
    NSInteger style = UITableViewCellEditingStyleDelete;
    if (indexPath.row == numberOfcountries) {
        style = UITableViewCellEditingStyleInsert;
    }
    return style;
}

@end

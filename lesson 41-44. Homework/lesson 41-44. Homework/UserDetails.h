//
//  UserDetails.h
//  lesson41-CoreDataPart1Basic
//
//  Created by Admin on 3/16/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerForCoreData.h"
@class UsersMO;

@interface UserDetails : UITableViewController <UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UsersMO* userForParsing;
@end

//
//  TestProtocol.h
//  PrTest
//
//  Created by Admin on 7/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

//STEP 1: creating a protocol and all included methods and properties
@protocol TestProtocol <NSObject>

@required

@property (strong, nonatomic) NSString * patientName;

- (BOOL) areYouOK;
- (void) takePill;
- (void) makeShot;


@optional

- (NSString *) howIsYourFamily;
- (BOOL) doYouHaveAnimals;

@end

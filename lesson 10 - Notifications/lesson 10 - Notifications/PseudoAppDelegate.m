//
//  PseudoAppDelegate.m
//  lesson 10 - Notifications
//
//  Created by Admin on 2/17/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "PseudoAppDelegate.h"

@implementation PseudoAppDelegate

-(id) init {
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(applicationDidFinishLaunchingNotification:)
                   name:UIApplicationDidFinishLaunchingNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationWillResignActiveNotification:)
                   name:UIApplicationWillResignActiveNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationDidEnterBackgroundNotification:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationWillEnterForegroundNotification:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationDidBecomeActiveNotification:)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
        [nc addObserver:self
               selector:@selector(applicationWillTerminateNotification:)
                   name:UIApplicationWillTerminateNotification
                 object:nil];
    }
    
    return self;
}

-(void) dealloc {
    NSLog(@"PseudoAppDelegate is deallocated");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// These notifications are sent out after the equivalent delegate message is called
/*
UIKIT_EXTERN NSString *const UIApplicationDidEnterBackgroundNotification       NS_AVAILABLE_IOS(4_0);
UIKIT_EXTERN NSString *const UIApplicationWillEnterForegroundNotification      NS_AVAILABLE_IOS(4_0);
UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;
UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationDidReceiveMemoryWarningNotification;
UIKIT_EXTERN NSString *const UIApplicationWillTerminateNotification;
UIKIT_EXTERN NSString *const UIApplicationSignificantTimeChangeNotification;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarFrameNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarFrameNotification;
*/
#pragma mark - Notifications activity
//pattern
-(void) name: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'PLACEHOLDERforNAME'. user info: %@", receivedNotification.userInfo);
}
//nessesary
-(void) applicationDidFinishLaunchingNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationDidFinishLaunchingNotification'. user info: %@", receivedNotification.userInfo);
}
-(void) applicationWillResignActiveNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationWillResignActiveNotification'. user info: %@", receivedNotification.userInfo);
}
-(void) applicationDidEnterBackgroundNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationDidEnterBackgroundNotification'. user info: %@", receivedNotification.userInfo);
}
-(void) applicationWillEnterForegroundNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationWillEnterForegroundNotification'. user info: %@", receivedNotification.userInfo);
}
-(void) applicationDidBecomeActiveNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationDidBecomeActiveNotification'. user info: %@", receivedNotification.userInfo);
}
-(void) applicationWillTerminateNotification: (NSNotification*) receivedNotification {
    NSLog(@"PseudoAppDelegate received 'UIApplicationWillTerminateNotification'. user info: %@", receivedNotification.userInfo);
}


@end



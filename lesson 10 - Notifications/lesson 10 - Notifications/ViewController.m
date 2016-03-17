//
//  ViewController.m
//  lesson 10 - Notifications
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SS: just for demonstraition that VC is loaded
    CGFloat width = self.view.frame.size.width;
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 20, width-20, 50)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    // Do any additional setup after loading the view, typically from a nib.
    //test. It works !
    /*
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(applicationDidEnterBackgroundNotification:)
               name:UIApplicationDidFinishLaunchingNotification
             object:nil];
    [nc addObserver:self
           selector:@selector(applicationWillChangeStatusBarOrientation:)
               name:UIApplicationWillChangeStatusBarOrientationNotification
             object:nil];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
# pragma mark - Notifications
-(void) applicationDidEnterBackgroundNotification: (NSNotification*) receivedNotification {
    NSLog(@"ViewController-class have got DidEnterBackgroundNotification. UserInfo: %@",  receivedNotification.userInfo);
}
-(void) applicationWillChangeStatusBarOrientation: (NSNotification*) receivedNotification {
    NSLog(@"ViewController-class have got UIApplicationWillChangeStatusBarOrientationNotification. UserInfo: %@",  receivedNotification.userInfo);
}
*/

@end

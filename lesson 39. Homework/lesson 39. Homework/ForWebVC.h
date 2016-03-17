//
//  ForWebVC.h
//  lesson 39. Homework
//
//  Created by Admin on 3/2/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForWebVC : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSURLRequest* receivedRequest;


-(id) initWithURLRequest: (NSURLRequest*) request;

@end

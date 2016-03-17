//
//  ForWebVC.m
//  lesson 39. Homework
//
//  Created by Admin on 3/2/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ForWebVC.h"

@interface ForWebVC ()
- (IBAction)actionBack:(id)sender;

- (IBAction)actionForward:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtom;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@end

@implementation ForWebVC

- (id) initWithURLRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        self.receivedRequest = request;
    }
    NSLog(@"ForWebVC-instance with request is created");
    return self;
}
-(id) init {
    self = [super init];
    NSLog(@"ForWebVC-instance is inited");
    return self;
}


- (void)viewDidLoad {
    
    NSString* titleString = self.receivedRequest.URL.absoluteString;
    if ([titleString containsString:@"http"]) {
        self.navigationItem.title = titleString;
    } else {
        self.navigationItem.title = [titleString lastPathComponent];
    }
    [super viewDidLoad];
    self.indicator.hidesWhenStopped = YES;
    NSLog(@"ForWebVC viewDidLoad");
    self.webView.delegate = self;
    [self.webView loadRequest:self.receivedRequest];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UIWebViewDelegate
//level 6
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    [self.indicator startAnimating];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    [self.indicator stopAnimating];
    self.backButtom.enabled = [self.webView canGoBack];
    self.forwardButton.enabled = [self.webView canGoForward];

}

# pragma mark - Actions


- (IBAction)actionBack:(id)sender {
    [self.webView stopLoading];
    [self.webView goBack];
}

- (IBAction)actionForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}
@end

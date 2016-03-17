//
//  InitialTVC.m
//  lesson 39. Homework
//
//  Created by Admin on 3/2/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "InitialTVC.h"

@interface InitialTVC ()
@property (strong, nonatomic) NSArray* arrayForURLs;
@property (strong, nonatomic) NSArray* arrayForFilePathes;

@end

@implementation InitialTVC
-(id) init {
    self = [super init];
    NSLog(@"InitialTVC.h is inited");
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"test web-view (homework)";
    NSString* wiki = @"https://en.wikipedia.org/wiki/Software_design_pattern";
    NSString* radioSvoboda = @"http://www.radiosvoboda.org/";
    NSString* dou = @"http://dou.ua/";
    self.arrayForURLs = [[NSArray alloc] initWithObjects:wiki, radioSvoboda, dou, nil];
    
    NSString* pdfName1 = @"BecomeAnXcoder.pdf";
    NSString* pdfName2 = @"Trudoustroystvo_Junior_iOS_razrabotchika.pdf";
    NSString* pdfName3 = @"Vostok-Stroy (member 1).pdf";
    self.arrayForFilePathes = [[NSArray alloc] initWithObjects:pdfName1, pdfName2, pdfName3, nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURLRequest* uRLRequest;
    if (indexPath.section == 0) {
        NSString* urlStringForSelected = [self.arrayForURLs objectAtIndex:indexPath.row];
        NSURL* URL = [NSURL URLWithString:urlStringForSelected];
        uRLRequest = [NSURLRequest requestWithURL:URL];
    } else {
        NSString* nameForSelected = [self.arrayForFilePathes objectAtIndex:indexPath.row];
        NSString* filePath = [[NSBundle mainBundle] pathForResource:nameForSelected ofType:nil];
        NSURL* fileUrl = [NSURL fileURLWithPath:filePath];
        uRLRequest = [NSURLRequest requestWithURL:fileUrl];
    }
    //ForWebVC* webVC = [[ForWebVC alloc] initWithURLRequest:uRLRequest];
    ForWebVC* webVCFromSB = [self.storyboard instantiateViewControllerWithIdentifier:@"ForWebVC-identifier"];
    webVCFromSB.receivedRequest = uRLRequest;
    //SS: IMPORTANTE !!! method bellow DOESN'T work without navigation Controller, that was created in storyoard !!! create it first (with assigning of rootViewController via "drag and drop")
    [self.navigationController pushViewController:webVCFromSB animated:YES];
}


@end

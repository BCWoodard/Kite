//
//  KTEAppReviewViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEAppReviewViewController.h"

@interface KTEAppReviewViewController ()
{
    __weak IBOutlet UIWebView *webView;
}

- (IBAction)dismissAppReviewModal:(id)sender;

@end

@implementation KTEAppReviewViewController
@synthesize incomingApp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"Incoming appID: %i", incomingApp.appID);
    
    // Retrieve data
    //[self retrieveAppScreenData];
    
    NSString *urlString = @"http://res.cloudinary.com/hiydccde4/image/upload/v1379206487/prce2d1ymetptu3a84ma.jpg";
    // [NSString stringWithFormat:@"http://kite-api.herokuapp.com/apps/%i", incomingApp.appID];
    NSURL *url = [NSURL URLWithString:urlString];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAppReviewModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Retrieve Data
- (void)retrieveAppScreenData
{
    // Activate the Network Activity Indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://kite-api.herokuapp.com/apps/%i", incomingApp.appID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        // Create an array of app screens data and a mutable temp array to hold screen objects
//        NSArray *allAppScreens = [allAppData objectForKey:@"screens"];
//        NSLog(@"Screens count: %i", allAppScreens.count);
        
/*
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[allAppsArray count]];

        for (NSDictionary *dictionary in allAppsArray) {
            // Create an app using our init override method in App.m, set the shortlist value and add to our tempArray
            KTEApp *app = [[KTEApp alloc] initWithAppDictionary:dictionary];
            [tempArray addObject:app];
        }
        
        // Populate appsArray with tempArray
        // We do this to protect our arrays from accidental edits, etc.
        //appsArray = [NSArray arrayWithArray:tempArray];
*/        
        // Stop Activity Indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }];
}


@end

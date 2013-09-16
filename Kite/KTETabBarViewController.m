//
//  KTETabBarViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/15/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTETabBarViewController.h"
#import "KTEInitialViewController.h"
#import "KTEApp.h"

@interface KTETabBarViewController ()

@end

@implementation KTETabBarViewController
@synthesize appsArray;

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
        
    [self setSelectedIndex:1];
    [self.tabBar setTintColor:[UIColor colorWithRed:37.0/255.0 green:64.0/255.0 blue:143.0/255.0 alpha:1.0]];
    
    [self retrieveAppData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Retrieve Data
- (void)retrieveAppData
{
    // Activate the Network Activity Indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://kite-api.herokuapp.com/apps"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *allAppsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        // Create an array of movie data and a mutable temp array to hold movie objects
        NSArray *allAppsArray = [allAppsData objectForKey:@"apps"];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[allAppsArray count]];
        
        for (NSDictionary *dictionary in allAppsArray) {
            // Create an app using our init override method in App.m, set the shortlist value and add to our tempArray
            KTEApp *app = [[KTEApp alloc] initWithAppDictionary:dictionary];
            [tempArray addObject:app];
        }
        
        // Populate appsArray with tempArray
        // We do this to protect our arrays from accidental edits, etc.
        appsArray = [NSArray arrayWithArray:tempArray];
        NSLog(@"appsArray count (in Tab): %i", appsArray.count);
        
        // Stop Activity Indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }];
}



@end

//
//  KTENavigationViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/15/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTENavigationViewController.h"
#import "KTETabBarViewController.h"

@interface KTENavigationViewController ()

@end

@implementation KTENavigationViewController
@synthesize incomingApps;

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
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBG"]  forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

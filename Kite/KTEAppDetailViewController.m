//
//  KTEAppDetailViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEAppDetailViewController.h"
#import "KTEAppReviewViewController.h"

@interface KTEAppDetailViewController ()
{
    __weak IBOutlet UIView *rateAppOverlay;
    __weak IBOutlet UILabel *appAuthorLabel;
    __weak IBOutlet UILabel *appDescriptionLabel;
    
}

- (IBAction)openAppReviewModal:(id)sender;



@end

@implementation KTEAppDetailViewController
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
    
    // UI elements
    [self.navigationItem setTitle:incomingApp.appName];
    appAuthorLabel.text = incomingApp.appAuthor;
    appDescriptionLabel.text = incomingApp.appDescription;
    
    [rateAppOverlay setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openAppReviewModal:(id)sender
{
    [self performSegueWithIdentifier:@"toAppReview" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KTEAppReviewViewController *appReviewController = segue.destinationViewController;
    appReviewController.incomingApp = incomingApp;
}
@end

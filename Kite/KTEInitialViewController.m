//
//  KTEInitialViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEApp.h"
#import "KTEInitialViewController.h"
#import "KTETabBarViewController.h"
#import "KTEMarketViewController.h"
#import "KTERegistrationViewController.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface KTEInitialViewController ()
{
    NSArray                     *appsArray;
    BOOL                        dataReceived;
    __weak IBOutlet UITextField *userEmailTextField;
    __weak IBOutlet UITextField *userPasswordTextField;
}

- (IBAction)signInToKite:(id)sender;
- (IBAction)registerWithKite:(id)sender;

@end

@implementation KTEInitialViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:[UIColor colorWithRed:112.0/255.0 green:157.0/255.0 blue:200.0/255.0 alpha:1.0]];
    
    // Set delegates
    [userEmailTextField setDelegate:self];
    [userPasswordTextField setDelegate:self];
    
    // Set Boolean
    dataReceived = NO;
    
    // Check for internet and retrieve data
    [self checkForInternet];    
    
/*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setDataReceivedBoolean)
                                                 name:@"dataReceived"
                                               object:nil];
*/
}

- (void)setDataReceivedBoolean
{
    dataReceived = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInToKite:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://kite-api.herokuapp.com/authentications"];
    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:url];
    
    [postRequest setPostValue:userEmailTextField.text forKey:@"email"];
    [postRequest setPostValue:userPasswordTextField.text forKey:@"password"];
    [postRequest setRequestMethod:@"POST"];
    [postRequest addRequestHeader:@"Accept" value:@"application/json"];
    
    [postRequest startSynchronous];
    
    int statusCode = [postRequest responseStatusCode];
    NSString *statusMessage = [postRequest responseStatusMessage];
    NSLog(@"\nPOST Status Code: %i\nStatus Message: %@", statusCode, statusMessage);
    
    if (statusCode == 200) {
        NSLog(@"data received: %i", dataReceived);
        [self performSegueWithIdentifier:@"toMarketplaceView" sender:self];

    } else {
        NSLog(@"Error posting to Heroku:\n%@", statusMessage);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign In Error"
                                                            message:@"Your username or password were incorrect. Please try again."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
    }
}


- (IBAction)registerWithKite:(id)sender
{
    [self performSegueWithIdentifier:@"toRegisterView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.description isEqualToString:@"toMarketplaceView"]) {
        KTETabBarViewController *tabViewController = segue.destinationViewController;
        tabViewController.selectedIndex = 1;
        tabViewController.appsArray = appsArray;
        
    } else {
        KTERegistrationViewController *registrationViewController = segue.destinationViewController;
        registrationViewController.delegate = self;
    }
}




#pragma mark - REACHABILITY Methods
- (void)checkForInternet
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            [self showReachabilityAlertView];
            NSLog(@"There's no internet connection at all.");
            break;
            
        case ReachableViaWWAN:
            NSLog(@"We have a 3G connection");
            break;
            
        case ReachableViaWiFi:
            NSLog(@"We have WiFi.");
            break;
            
        default:
            break;
    }
}


- (void)showReachabilityAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Connection!"
                                                        message:@"Kite is unable to reach the Internet. Please check your device settings or try later."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    
}


#pragma mark - DELEGATE
- (void)passBackLoginEmail:(NSString *)loginEmail andLoginPassword:(NSString *)loginPassword
{
    userEmailTextField.text = loginEmail;
    userPasswordTextField.text = loginPassword;
}


@end

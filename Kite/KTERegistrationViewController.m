//
//  KTEViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTERegistrationViewController.h"
#import "KTEMarketViewController.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "KTEApp.h"
#import "KTEUser.h"

@interface KTERegistrationViewController ()
{
    NSArray                     *usersArray;
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UITextField *fNameTextField;
    __weak IBOutlet UITextField *lNameTextField;
    __weak IBOutlet UITextField *eMailTextField;    
    __weak IBOutlet UITextField *passwordTextField;
    __weak IBOutlet UITextField *ageTextField;    
    __weak IBOutlet UITextField *genderTextField;
    __weak IBOutlet UITextField *zipCodeTextField;
}

- (IBAction)registerForKite:(id)sender;
- (IBAction)cancelRegistration:(id)sender;


@end

@implementation KTERegistrationViewController
@synthesize incomingAppsArray;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI Elements
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setBackgroundColor:[UIColor colorWithRed:112.0/255.0 green:157.0/255.0 blue:200.0/255.0 alpha:1.0]];
    
    // Set textField delegates
	[fNameTextField setDelegate:self];
    [lNameTextField setDelegate:self];
    [eMailTextField setDelegate:self];
    [passwordTextField setDelegate:self];
    [ageTextField setDelegate:self];
    [genderTextField setDelegate:self];
    [zipCodeTextField setDelegate:self];
    
    // Retrieve data
    [self retrieveUserData];

}


- (void)viewWillAppear:(BOOL)animated
{
     [fNameTextField setText:@""];
     [lNameTextField setText:@""];
     [eMailTextField setText:@""];
     [passwordTextField setText:@""];
     [ageTextField setText:@""];
     [genderTextField setText:@""];
     [zipCodeTextField setText:@""];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)registerForKite:(id)sender
{    
    NSURL *url = [NSURL URLWithString:@"http://kite-api.herokuapp.com/users"];    
    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:url];
    NSString *registerUsername = [NSString stringWithFormat:@"%@ %@", fNameTextField.text, lNameTextField.text];
    [postRequest setPostValue:registerUsername forKey:@"name"];
    [postRequest setPostValue:eMailTextField.text forKey:@"email"];
    [postRequest setPostValue:passwordTextField.text forKey:@"password"];
    [postRequest setRequestMethod:@"POST"];
    [postRequest addRequestHeader:@"Accept" value:@"application/json"];

    [postRequest startSynchronous];
    
    int statusCode = [postRequest responseStatusCode];
    NSString *statusMessage = [postRequest responseStatusMessage];
    NSLog(@"\nPOST Status Code: %i\nStatus Message: %@", statusCode, statusMessage);
    
    if (statusCode == 200) {
        if([self.delegate respondsToSelector:@selector(passBackLoginEmail:andLoginPassword:)])
        {
            [self.delegate passBackLoginEmail:eMailTextField.text andLoginPassword:passwordTextField.text];
        }
            [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"Error posting to Heroku:\n%@", statusMessage);
    }
}

- (IBAction)cancelRegistration:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Retrieve data
- (void)retrieveUserData
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://kite-api.herokuapp.com/users"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *allUsersData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        // Create an array of users data and a mutable temp array to hold user objects
        NSArray *allUsersArray = [allUsersData objectForKey:@"users"];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[allUsersArray count]];
        
        for (NSDictionary *dictionary in allUsersArray) {
            // Create an app using our init override method in App.m, set the shortlist value and add to our tempArray
            KTEUser *user = [[KTEUser alloc] initWithUserDictionary:dictionary];
            [tempArray addObject:user];
        }
        
        // Populate usersArray with tempArray
        // We do this to protect our arrays from accidental edits, etc.
        usersArray = [NSArray arrayWithArray:tempArray];
        NSLog(@"usersArray count: %i", usersArray.count);
                
        // Stop Activity Indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];

}
@end

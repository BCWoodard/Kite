//
//  KTEMarketViewController.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEMarketViewController.h"
#import "KTENavigationViewController.h"
#import "KTEAppDetailViewController.h"
#import "KTECustomCell.h"
#import "KTEApp.h"

@interface KTEMarketViewController ()
{
    __weak IBOutlet UITableView *marketTable;
    int                         selectedRow;
    NSArray                     *appsArray;
    
}

@end

@implementation KTEMarketViewController
@synthesize incomingAppsArray;

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
    
    [self.navigationController setNavigationBarHidden:NO];
        
    [self retrieveAppData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadMarketTable)
                                                 name:@"dataReceived"
                                               object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES animated:NO];
    NSIndexPath *selectedIndexPath = [marketTable indexPathForSelectedRow];
    [marketTable deselectRowAtIndexPath:selectedIndexPath animated:YES];

}

- (void)reloadMarketTable
{
    [marketTable reloadData];
}


#pragma mark - UITableViewDataSource
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    KTEApp *app = [appsArray objectAtIndex:indexPath.row];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey.jpg"]];
    cell.imageView.image = [UIImage imageNamed:@"thumbnail_App"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = app.appName;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = app.appDescription;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"toAppDetailView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KTEAppDetailViewController *appDetailView = segue.destinationViewController;
    appDetailView.incomingApp = [appsArray objectAtIndex:selectedRow];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
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
        NSLog(@"appsArray count: %i", appsArray.count);
        
        // Send notification that our download is complete
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataReceived" object:self];
        
        // Stop Activity Indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

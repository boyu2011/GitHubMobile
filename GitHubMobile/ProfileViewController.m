//
//  ProfileViewController.m
//  GitHubMobile
//
//  Created by Bo Yu on 1/2/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

@synthesize userSummaryButton;
@synthesize repositoryInfo;
@synthesize followingButton;
@synthesize followersButton;
@synthesize githubEngine;


- (void)init:(UAGithubEngine *)githubEngine
{
    self.githubEngine = githubEngine;
    // need realloc memory???
    self.githubEngine = [[UAGithubEngine alloc] initWithUsername:self.githubEngine.username password:self.githubEngine.password delegate:self withReachability:YES];
    [self.githubEngine user:githubEngine.username];
    [self.githubEngine repositoriesForUser:githubEngine.username includeWatched:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"repositories"])
    {
        [segue.destinationViewController init:self.githubEngine];
    }
    else if([segue.identifier isEqualToString:@"userSummary"])
    {
        [segue.destinationViewController init:self.githubEngine];
    }
    else if ([segue.identifier isEqualToString:@"following"])
    {
        [segue.destinationViewController init:self.githubEngine];
    }
    else if ([segue.identifier isEqualToString:@"followers"])
    {
        [segue.destinationViewController init:self.githubEngine];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setRepositoryInfo:nil];
    [self setUserNameLabel:nil];
    [self setUserSummaryButton:nil];
    [self setFollowingAndFollowerControl:nil];
    [self setFollowingButton:nil];
    [self setFollowersButton:nil];
    [self setTestButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [repositoryInfo release];
    [userSummaryButton release];
    [followingButton release];
    [followersButton release];
    [super dealloc];
}

#pragma mark UAGithubEngineDelegate Methods

- (void)requestSucceeded:(NSString *)connectionIdentifier
{
	NSLog(@"Request succeeded: %@", connectionIdentifier);
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
    NSLog(@"Request failed: %@, error: %@ (%@)", connectionIdentifier, [error localizedDescription], [error userInfo]);	
}

#pragma mark github api

- (void)repositoriesReceived:(NSArray *)repositories forConnection:(NSString *)connectionIdentifier
{
    NSLog(@"Received repositories for connection: %@, %@", connectionIdentifier, repositories);
    
    NSUInteger * repoCount = [repositories count];
    NSString *repoCountString = [NSString stringWithFormat:@"Repositories: %d", repoCount];
    
    [repositoryInfo setTitle:repoCountString forState:UIControlStateNormal];
}

- (void)usersReceived:(NSArray *)users forConnection:(NSString *)connectionIdentifier
{
    NSLog(@"Received users: %@, %@", connectionIdentifier, users);
    
    NSArray * userArray = users;
    id val;
    
    if([userArray count] != 0)
    {
        // user 0
        val = [userArray objectAtIndex:0];
        NSString * userName = [val valueForKey:@"name"];
        NSUInteger * following_count = [[val valueForKey:@"following_count"] integerValue];
        NSUInteger * followers_count = [[val valueForKey:@"followers_count"] integerValue];
        NSString * formattedFollowingString = [NSString stringWithFormat:@"Following: %d", following_count];
        NSString * formattedFollowersString = [NSString stringWithFormat:@"Followers: %d", followers_count];

        [userSummaryButton setTitle:userName forState:UIControlStateNormal];
        
        [followingButton setTitle:formattedFollowingString forState:UIControlStateNormal];
        [followersButton setTitle:formattedFollowersString forState:UIControlStateNormal];
    }    
}

@end

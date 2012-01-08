//
//  LoginViewController.m
//  GitHubMobile
//
//  Created by Bo Yu on 1/3/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize loginId;
@synthesize password;
@synthesize githubEngine;

- (IBAction)login:(id)sender {
    
    // login id can not be empty
    if([loginId.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
														message:@"Loing ID can't be blank!"
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
    }
    // password can not be empty
    else if ([password.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
														message:@"Password can't be blank!"
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
    }
    // authenticate user information
    else
    {
        self.githubEngine = [[UAGithubEngine alloc] initWithUsername:self.loginId.text password:self.password.text delegate:self withReachability:YES];
        [self.githubEngine user:self.loginId.text];
    }
}

- (IBAction)logout:(id)sender 
{
    loginId.text = @"";
    password.text = @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"profile"])
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setLoginId:nil];
    [self setPassword:nil];
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
    [loginId release];
    [password release];
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

}

- (void)usersReceived:(NSArray *)users forConnection:(NSString *)connectionIdentifier
{
    NSLog(@"Received users: %@, %@", connectionIdentifier, users);
    
    //when pass through authentication, you will get total_private_repo_count information.
    NSArray * userArray = users;
    id val;
    
    if([userArray count] != 0)
    {
        // user 0
        val = [userArray objectAtIndex:0];
        
        id * i = [val objectForKey:@"total_private_repo_count"];
       
        if(i!=nil)
        {
            // go to profile view controller.
            [self performSegueWithIdentifier:@"profile" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
                                                            message:@"Login failed!"
                                                           delegate:nil 
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
}

@end

//
//  CommitListViewController.m
//  GitHubMobile
//
//  Created by Bo Yu on 1/7/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import "CommitListViewController.h"


@implementation CommitListViewController

@synthesize githubEngine;

@synthesize commits;

- (void)init:(UAGithubEngine *)githubEngine userRepoName:(NSString *)userRepoName branchName:(NSString *)branchName
{
    self.githubEngine = githubEngine;
    self.githubEngine = [[UAGithubEngine alloc] initWithUsername:self.githubEngine.username password:self.githubEngine.password delegate:self withReachability:YES];
    
    NSString * userRepoBranchName = [userRepoName stringByAppendingString:@"/"];
    userRepoBranchName = [userRepoBranchName stringByAppendingString:branchName];
    
    [self.githubEngine commitsForBranch:userRepoBranchName];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"commitCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    /*
    NSDictionary * repository = [self.repos objectAtIndex:indexPath.row];
    NSString * fullName = [repository valueForKey:@"owner"];
    fullName = [fullName stringByAppendingString:@"/"];
    fullName = [fullName stringByAppendingString:[repository valueForKey:@"name"]];
    cell.textLabel.text = fullName;
    cell.detailTextLabel.text = [repository valueForKey:@"description"];
    */
    
    NSDictionary * commit = [self.commits objectAtIndex:indexPath.row];
    cell.textLabel.text = [commit valueForKey:@"message"];
    cell.detailTextLabel.text = [commit valueForKey:@"committed_date"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
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

#pragma mark Commits

- (void)commitsReceived:(NSArray *)commits forConnection:(NSString *)connectionIdentifier
{
    NSLog(@"Received commits for connection: %@, %@", connectionIdentifier, commits);
    
    self.commits = commits;
    [self.tableView reloadData];
}

@end

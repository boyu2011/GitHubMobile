//
//  CommitListViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/7/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface CommitListViewController : UITableViewController <UAGithubEngineDelegate>

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@property (nonatomic, retain) NSArray * commits;

- (void)init:(UAGithubEngine *)githubEngine userRepoName:(NSString *)userRepoName branchName:(NSString *)branchName;

@end

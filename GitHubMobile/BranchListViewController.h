//
//  BranchListViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/7/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface BranchListViewController : UITableViewController <UAGithubEngineDelegate>

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@property (nonatomic, retain) NSArray * branchArray;

@property (nonatomic, retain) NSString * userRepoName;

- (void)init:(UAGithubEngine *)githubEngine repositoryName:(NSString *)name;

@end

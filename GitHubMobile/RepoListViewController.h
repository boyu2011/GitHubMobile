//
//  RepoListViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/2/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface RepoListViewController : UITableViewController <UAGithubEngineDelegate> {

}

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@property (nonatomic, retain) NSArray * repos; // of repository dictionaries 

- (void)init:(UAGithubEngine *)githubEngine;

@end

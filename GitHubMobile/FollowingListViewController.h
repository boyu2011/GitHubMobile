//
//  FollowingListViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/5/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface FollowingListViewController : UITableViewController <UAGithubEngineDelegate>

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@property (nonatomic, retain) NSArray * following; // of repository dictionaries 

- (void)init:(UAGithubEngine *)githubEngine;

@end

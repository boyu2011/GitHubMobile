//
//  UserSummaryViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/4/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface UserSummaryViewController : UITableViewController

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@property (nonatomic, retain) NSMutableDictionary * userSummaryDic;

@property (nonatomic, retain) NSMutableArray * userSummaryArray;

- (void)init:(UAGithubEngine *)githubEngine;

@end

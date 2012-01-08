//
//  ProfileViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/2/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface ProfileViewController : UIViewController <UAGithubEngineDelegate> {

}

@property (retain, nonatomic) IBOutlet UIButton *userSummaryButton;
@property (retain, nonatomic) IBOutlet UIButton *repositoryInfo;
@property (retain, nonatomic) IBOutlet UIButton *followingButton;
@property (retain, nonatomic) IBOutlet UIButton *followersButton;

@property (nonatomic, retain) UAGithubEngine * githubEngine;

- (void)init:(UAGithubEngine *)githubEngine;

@end

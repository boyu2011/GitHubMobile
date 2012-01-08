//
//  LoginViewController.h
//  GitHubMobile
//
//  Created by Bo Yu on 1/3/12.
//  Copyright (c) 2012 BoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h"

@interface LoginViewController : UIViewController <UAGithubEngineDelegate>

@property (retain, nonatomic) IBOutlet UITextField *loginId;
@property (retain, nonatomic) IBOutlet UITextField *password;

@property (nonatomic, retain) UAGithubEngine * githubEngine;

@end

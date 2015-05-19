//
//  TwitterViewController.m
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/23/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import "TwitterViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterFollowerList.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)TwitterView
{
    
    
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitterButton.frame = CGRectMake(50, 70, 130, 50);
    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(postToTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];
    

    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    post.frame = CGRectMake(50, 130, 190, 50);
    [post setTitle:@"Get Friend List" forState:UIControlStateNormal];
    [post setBackgroundColor:[UIColor clearColor]];
    [post addTarget:self action:@selector(FriendListViewControllerMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:post];

    
}

- (void)postToTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Great fun to learn iOS programming at softwareWeaver!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    
}

-(void)FriendListViewControllerMethod
{
    TwitterFollowerList *follower = [[ TwitterFollowerList alloc]init];
    [self.navigationController pushViewController:follower animated:NO];
}



- (void)viewDidLoad
{
    [self TwitterView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

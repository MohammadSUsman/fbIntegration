//
//  ViewController.m
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/22/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import "ViewController.h"
#import "FacebookFriendList.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TwitterViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self ScreenView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)ScreenView
{
    
    myview = [[UIView alloc]init];
    [myview setFrame:CGRectMake(0, 0, 320, 460)];
    [myview setBackgroundColor:[UIColor whiteColor]];
    
    fbLoginview = [[FBLoginView alloc]initWithReadPermissions:@[@"read_friendlists"]];
    [fbLoginview setDelegate:self];   
    [fbLoginview setFrame:CGRectMake(60, 50, 200, 60)];

    
    [fbLoginview setBackgroundColor:[UIColor whiteColor]];
    [myview addSubview:fbLoginview];
    
    getFriendListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getFriendListButton setFrame:CGRectMake(60, 100, 200, 40)];
    [getFriendListButton setTitle:@"GET FRiends List" forState:UIControlStateNormal];
    [getFriendListButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [getFriendListButton addTarget:self action:@selector(Friendlist) forControlEvents:  UIControlEventTouchUpInside];
    [myview addSubview: getFriendListButton];
    
    [self.view addSubview:myview];
    
    
   UIButton *postOnuserWall = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postOnuserWall.frame = CGRectMake(60, 150, 200, 40);
    [postOnuserWall setTitle:@"myWallPost" forState:UIControlStateNormal];
    [postOnuserWall setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [postOnuserWall addTarget:self action:@selector(userwallpost) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postOnuserWall];
    
    
    
    UIButton *twitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twitter setFrame:CGRectMake(60, 200, 200, 40)];
    [twitter setTitle:@"Twitte" forState:UIControlStateNormal];
    [twitter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [twitter addTarget:self action:@selector(TwitterMethod) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:twitter];
    
    
}

-(void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    [FBRequestConnection startWithGraphPath:@"/{friendlist-id}"
                                 parameters:nil
                                 HTTPMethod:@"GET" completionHandler:^
     (
      FBRequestConnection *connection,
      id result,
      NSError *error
      )
     {
     }
     ];
    
}

-(void)Friendlist
{
    
    FacebookFriendList *friendlistviewcontrollerobject=[[FacebookFriendList alloc]init];
    [self.navigationController pushViewController:friendlistviewcontrollerobject animated:NO];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{

   // [FBSession.activeSession closeAndClearTokenInformation];
   // [FBSession.activeSession close];
    //[FBSession setActiveSession:nil];
    
  //  [getFriendListButton removeFromSuperview];
    // [postOnYourPublicWallButton removeFromSuperview];
    
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    [myview addSubview: getFriendListButton];

 
}

-(void)userwallpost
{

    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:nil
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
     
     {
         
         
     }
     ];
}


-(void)TwitterMethod
{
    TwitterViewController *twitterview = [[TwitterViewController alloc]init];
    
    [self.navigationController pushViewController: twitterview animated:YES];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  //  [myview addSubview: getFriendListButton];
// Dispose of any resources that can be recreated.
}

@end

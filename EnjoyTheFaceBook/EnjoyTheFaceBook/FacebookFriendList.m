//
//  FacebookFriendList.m
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/22/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import "FacebookFriendList.h"

@interface FacebookFriendList ()

@end

@implementation FacebookFriendList
@synthesize friendPickerViewController;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        
    {
        // Custom initialization
    }
    return self;
}

-(void)FriendListView
{
    UIBarButtonItem *mydonebutton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"ok" style:UIBarButtonItemStylePlain target:self action:@selector(PickFriends:)];
    self.navigationItem.rightBarButtonItem = mydonebutton;
    

}

- (void)viewDidLoad
{
    
    friendPickerViewController = [[FBFriendPickerViewController alloc]init];
    [self FriendListView];
   // [self facebookRequest];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)facebookRequest
{
    if (!FBSession.activeSession.isOpen) {
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,FBSessionState state,NSError *error){
            switch (state) {
                case FBSessionStateClosedLoginFailed:
                {
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    [friendPickerViewController setAllowsMultipleSelection:NO];
    [friendPickerViewController setDisplayOrdering:FBFriendDisplayByFirstName];
    [friendPickerViewController setDoneButton:done];////
    
    if (self.friendPickerViewController == nil) {
        
        self.friendPickerViewController=[[FBFriendPickerViewController alloc]init];
        [self.friendPickerViewController setTitle:@"Pick Friends"];
        [self.friendPickerViewController setDelegate:self];
        
    }
    [self.friendPickerViewController setTitle:@"Pick Friends"];
    
    [self.friendPickerViewController loadData];
    [self.friendPickerViewController clearSelection];
    [self.friendPickerViewController.view setFrame:CGRectMake(0, 0, 320, 383)];
    
    [self.view addSubview:self.friendPickerViewController.view];
    
}
-(void)PickFriends:(id)sender
{
    for(id<FBGraphUser> sender in friendPickerViewController.selection)
    {
        
        if (friendPickerViewController.selection != nil)
        {
            UIAlertView *postOnfriendsWall = [[UIAlertView alloc]initWithTitle:@"Post " message:@"On Freind's Wall" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            [postOnfriendsWall show];
            
        }
    }
    
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
        for(id<FBGraphUser> sender in friendPickerViewController.selection)
        {
            NSMutableDictionary *params =
            [NSMutableDictionary dictionaryWithObjectsAndKeys:
             [NSString stringWithFormat:@"%@",sender.id],@"to"
             ,     nil];
            
            [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                   parameters:params
                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
             {
                 if (!error)
                 {
                     NSLog(@" heloo %u",result);
                 }
             }
             ];
            
        }
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

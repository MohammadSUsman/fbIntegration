//
//  TwitterFollowerList.m
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/23/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import "TwitterFollowerList.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "TwitterCell.h"
#import <Foundation/Foundation.h>
@interface TwitterFollowerList ()

{
    UITableView *myTableView;
    NSDictionary *followerData;
    
}


@end

@implementation TwitterFollowerList
@synthesize followerDictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView registerClass:[TwitterCell class]forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:myTableView];
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:twitterAccountType
                                          options:nil
                                       completion:^(BOOL granted, NSError *error)
     {
         
         if (granted)
         {
             
             NSLog(@"Granted!");
             
             NSArray *arrayOfAccounts = [accountStore accountsWithAccountType:twitterAccountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 
                 ACAccount *acct = [[accountStore accountsWithAccountType:twitterAccountType]lastObject];
                 
                 [self fetchTwitterFollowersForAccount:acct];
                 
             }
             else
             {
                 NSLog(@"No permission :(  %@", error);
             }
         }
     }];

	// Do any additional setup after loading the view.
}


-(void)fetchTwitterFollowersForAccount:(ACAccount *)twitterAccount

{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat
                                       :@"https://api.twitter.com/1.1/followers/list.json"]];
    id params = @{@"user_name":twitterAccount.username};
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url
                                               parameters:params];
    request.account = twitterAccount;
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
     {
         if (responseData)
         {
             if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300)
             {
                 NSError *jsonError = nil;
                 NSDictionary *followerData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                              options:NSJSONReadingAllowFragments
                                                                                error:&jsonError];
                 if (followerData)
                 {
                     NSLog(@"Response: %@", followerData);
                     self.followerDictionary = followerData;
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        [myTableView reloadData];
                                    });
                 }
                 else
                 {
                     NSLog(@"JSON Parsing error: %@", jsonError);
                 }
             }
             else
             {
                 NSLog(@"Server returned HTTP %d", urlResponse.statusCode);
             }
         }
         else
         {
             NSLog(@"Something went wrong: %@", [error localizedDescription]);
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         });
     }];
}

- (NSArray *)followers
{
    return self.followerDictionary[@"users"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = [[self followers] count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    followerData = [self followers][indexPath.row];
    
    cell.textLabel.text = followerData[@"screen_name"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    followerData = [self followers][indexPath.row];
    NSLog(@"%@",followerData[@"screen_name"]);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

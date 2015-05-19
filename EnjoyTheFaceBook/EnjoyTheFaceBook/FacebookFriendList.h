//
//  FacebookFriendList.h
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/22/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookFriendList : UIViewController <FBLoginViewDelegate , UIAlertViewDelegate,FBViewControllerDelegate>

{
    NSMutableArray *arrayOFFriends;
    UIBarButtonItem *done;
}


@property(strong , nonatomic) FBFriendPickerViewController *friendPickerViewController;

@end

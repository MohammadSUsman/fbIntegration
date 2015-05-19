//
//  ViewController.h
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/22/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <FBLoginViewDelegate>

{
    UIView *myview;
    FBLoginView *fbLoginview;
    
    UIButton *getFriendListButton;
   // UIButton *postYourWallButton;
    
}

@end

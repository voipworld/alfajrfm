//
//  TwitterVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/18/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLS.h"

@interface TwitterVC : UIViewController{
    
    IBOutlet UIBarButtonItem *backButton;

    IBOutlet UIWebView *twitterWebview;

}

@property(nonatomic,retain)IBOutlet UIWebView *twitterWebview;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;


-(IBAction)dismissModalController:(id)sender;



@end

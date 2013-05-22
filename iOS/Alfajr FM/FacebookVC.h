//
//  FacebookVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/18/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLS.h"

@interface FacebookVC : UIViewController{
    

    IBOutlet UIWebView *facebookWebview;

    IBOutlet UIBarButtonItem *backButton;
}

@property(nonatomic,retain)IBOutlet UIWebView *facebookWebview;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;


-(IBAction)dismissModalController:(id)sender;

@end

//
//  AboutVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutVC : UIViewController {
    
    
    IBOutlet UITextView *aboutInformationLabel;
    
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UIWebView *infoWebView;
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navBarTitle;
}

@property(nonatomic,retain)IBOutlet UIWebView *infoWebView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UITextView *aboutInformationLabel;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarTitle;
-(IBAction)dismissModalController:(id)sender;

@end

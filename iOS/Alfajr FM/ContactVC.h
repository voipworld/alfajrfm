//
//  ContactVCViewController.h
//  Alfajr FM
//
//  Created by John Doe on 3/13/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactVC : UIViewController {



    IBOutlet UIWebView *contactWebView;

}

@property(nonatomic,retain)IBOutlet UIWebView *contactWebView;


-(IBAction)dismissModalController:(id)sender;

@end
//
//  ContactVCViewController.m
//  Alfajr FM
//
//  Created by John Doe on 3/13/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "ContactVC.h"


#define kINFO_URL @"http://www.alfajrfm.com/contact"



@interface ContactVC ()

@end

@implementation ContactVC

@synthesize contactWebView;




- (void)viewDidLoad
{
    [self initMisc];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self initMisc];
    
}

#pragma mark -
#pragma mark init


-(void)initMisc{
    
    [self.contactWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kINFO_URL]]];
}


-(IBAction)dismissModalController:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}


@end

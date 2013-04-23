//
//  SecondViewController.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "SocialVC.h"

@interface SocialVC ()

@end

@implementation SocialVC
@synthesize navBar2;

@synthesize facebook;
@synthesize twitter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //  [self misc];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
     [self misc];
    
  }

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self misc];
    
}


-(void)misc{
    
    self.title =  NSLocalizedString(@"SocialVCTitle", nil);
    self.navBar2.topItem.title =  NSLocalizedString(@"SocialVCTitle", nil);

    
    [self.twitter setTitle: NSLocalizedString(@"follow_on_twitter", nil) forState:UIControlStateNormal];
    [self.facebook setTitle:  NSLocalizedString(@"connect_on_facebook", nil) forState:UIControlStateNormal];
        
}


#pragma mark -
#pragma mark Share actions




@end

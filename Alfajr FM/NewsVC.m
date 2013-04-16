//
//  ContactVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "NewsVC.h"
#define kNEWS_URL @"http://www.alfajrfm.com/news/"


@interface NewsVC ()

@end

@implementation NewsVC

@synthesize newsWebview;


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
    [self initMisc];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
   self.title =  NSLocalizedString(@"NewsVCTitle", nil);
}

#pragma mark -
#pragma mark init


-(void)initMisc{
    
    [self.newsWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kNEWS_URL]]];
}


@end

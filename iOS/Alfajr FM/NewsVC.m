//
//  ContactVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "NewsVC.h"



@interface NewsVC ()

@end

@implementation NewsVC

@synthesize newsWebview;
@synthesize navBar2;


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
    [self awakeFromNib];
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
    self.navBar2.topItem.title =  NSLocalizedString(@"NewsVCTitle", nil);
}

#pragma mark -
#pragma mark init


-(void)initMisc{
    
    URLS *urls = [URLS sharedInstance];
    
    NSString *kNEWS_URL = urls.news;
    
    [self.newsWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kNEWS_URL]]];
}


@end

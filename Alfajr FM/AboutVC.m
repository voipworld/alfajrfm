//
//  AboutVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "AboutVC.h"


#define kINFO_URL @"http://www.alfajrfm.com/about"


@interface AboutVC ()

@end

@implementation AboutVC

@synthesize infoWebView;
@synthesize backButton;
@synthesize aboutInformationLabel;
@synthesize navBar;

@synthesize navBarTitle;

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


-(void)viewWillAppear:(BOOL)animated{
    
    [self initMisc];
    
}

#pragma mark -
#pragma mark init


-(void)initMisc{
    
    [self.infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kINFO_URL]]];
    
    self.backButton.title = NSLocalizedString(@"back", nil);
    
    self.aboutInformationLabel.text = NSLocalizedString(@"aboutInformationLabel", nil);
    
    self.title = NSLocalizedString(@"about", nil);    
    self.navBarTitle.title = NSLocalizedString(@"about", nil);    
    
}


-(IBAction)dismissModalController:(id)sender{
    
// deprecated    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)viewDidUnload {
    backButton = nil;
    [self setBackButton:nil];
    backButton = nil;
    aboutInformationLabel = nil;
    [self setAboutInformationLabel:nil];
    navBar = nil;
    [self setNavBar:nil];
    navBarTitle = nil;
    [super viewDidUnload];
}
@end

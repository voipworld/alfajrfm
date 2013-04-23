//
//  FacebookVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/18/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "FacebookVC.h"


@interface FacebookVC ()

@end

@implementation FacebookVC

@synthesize facebookWebview;
@synthesize backButton;


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

#pragma mark -
#pragma mark init


-(void)initMisc{
    
    URLS *urls = [URLS sharedInstance];
    
    NSString *kURL = urls.facebook;
    
    [self.facebookWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kURL]]];
    
    self.backButton.title = NSLocalizedString(@"back", nil);
    
}

-(IBAction)dismissModalController:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)viewDidUnload {
    backButton = nil;
    [self setBackButton:nil];
    [super viewDidUnload];
}
@end

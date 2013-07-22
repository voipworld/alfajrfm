//
//  ProgramVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "ProgramVC.h"


@implementation ProgramVC

@synthesize programWebview;
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


-(void)viewWillAppear:(BOOL)animated{
    
    [self initMisc];
    
}

- (void)awakeFromNib
{
    self.title =  NSLocalizedString(@"ProgramVCTitle", nil);
     self.navBar2.topItem.title =  NSLocalizedString(@"ProgramVCTitle", nil);

}


#pragma mark -
#pragma mark init


-(void)initMisc{
    
    URLS *urls = [URLS sharedInstance];
    
    NSString *kPROGRAM_URL = urls.program;
    
    
   [self.programWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kPROGRAM_URL]]];
}

@end

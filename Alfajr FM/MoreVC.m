//
//  MoreVC.m
//  Alfajr FM
//
//  Created by John Doe on 4/22/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "MoreVC.h"

@interface MoreVC ()

@end

@implementation MoreVC
@synthesize navBar2;

@synthesize about;
@synthesize settings;

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
    [super viewDidLoad];
         [self misc];
	// Do any additional setup after loading the view.
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
    
    
    self.title =  NSLocalizedString(@"MoreVCTitle", nil);
    self.navBar2.topItem.title =  NSLocalizedString(@"MoreVCTitle", nil);
    self.about.titleLabel.text = NSLocalizedString(@"about", nil);
    self.settings.titleLabel.text = NSLocalizedString(@"settings", nil);

    
}

@end
   
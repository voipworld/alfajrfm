//
//  OptionsVC.m
//  Alfajr FM
//
//  Created by John Doe on 3/13/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "SettingsVC.h"




@implementation SettingsVC

@synthesize alwaysUseLowQualityWhenOn3G;
@synthesize threeG;
@synthesize quality;

@synthesize use3gLabel;
@synthesize streamingQualityLabel;
@synthesize alwaysUseLowQualityLabel;

@synthesize backButton;
@synthesize navBar;


- (void)viewDidLoad
{
    
    [self initLabels];
    [self initMisc];
    
    [super viewDidLoad];
    
    
 
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self initMisc];
    
}

- (void)awakeFromNib
{
    self.title =  NSLocalizedString(@"SettingsVCTitle", nil);
}


-(void)initLabels{
    
    
    self.use3gLabel.text = NSLocalizedString(@"use3gLabel", nil);
    
    self.streamingQualityLabel.text = NSLocalizedString(@"streamingQualityLabel", nil);
    
    self.alwaysUseLowQualityLabel.text = NSLocalizedString(@"alwaysUseLowQualityLabel", nil);
 
    [self.quality setTitle:NSLocalizedString(@"low", nil) forSegmentAtIndex:0];
    [self.quality setTitle:NSLocalizedString(@"high", nil) forSegmentAtIndex:1];

    self.backButton.title = NSLocalizedString(@"back", nil);
    
    self.navBar.title = NSLocalizedString(@"settings", nil);
    
    
}




-(void)initMisc {
 
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    
    if([ud boolForKey:@"use3G"]){
        
        self.threeG.on = YES;
 
    } else {
        
         self.threeG.on = NO;
    }
    
    if([ud boolForKey:@"streamingHighQuality"]){
        
        self.quality.selectedSegmentIndex =  1;
        
    } else {
        
        self.quality.selectedSegmentIndex =  0;
    }

    
    if([ud boolForKey:@"alwaysUseLowQualityWhenOn3G"]){
        
        self.alwaysUseLowQualityWhenOn3G.on = YES;
        
    } else {
        
        self.alwaysUseLowQualityWhenOn3G.on = NO;
    }
   
    [ud synchronize];
    
    /*
     
     IBOutlet UISwitch *threeG;
     
     IBOutlet UISwitch *alwaysUseLowQualityWhenOn3G;
     
     IBOutlet UISegmentedControl *quality;
     
     
    [ud setBool:YES forKey:@"use3G"];
    
    
    [ud setBool:YES forKey:@"streamingHighQuality"];
    
    
    [ud setBool:NO forKey:@"alwaysUseLowQualityWhenOn3G"];

    
    
    */
    
}



-(IBAction)didOnly3GToggled:(id)sender{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if(self.threeG.on){
        
        [ud setBool:YES forKey:@"use3G"];
        DLog(@"use3G ON");
        

        
    } else {
        
         [ud setBool:NO forKey:@"use3G"];
        DLog(@"use3G off");
        
     
    }
    
    [ud synchronize];
    
    [self postNotif];
    
}



-(IBAction)alwaysUseLowQualityWhenOn3GToggled:(id)sender{
    
     
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if(self.alwaysUseLowQualityWhenOn3G.on){
        
        [ud setBool:YES forKey:@"alwaysUseLowQualityWhenOn3G"];
        DLog(@"alwaysUseLowQualityWhenOn3G ON");
        
        
    } else {
        
        [ud setBool:NO forKey:@"alwaysUseLowQualityWhenOn3G"];
        DLog(@"alwaysUseLowQualityWhenOn3G OFF");
        
    }
    
    [ud synchronize];
    
    [self postNotif];
    
}


-(void)postNotif{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"settingsToggled" object:nil];

}



-(IBAction)didToggleQuality:(id)sender{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    switch (self.quality.selectedSegmentIndex) {
        case 0:
            [ud setBool:NO forKey:@"streamingHighQuality"];
             DLog(@"streamingHighQuality ON");
            break;
        case 1:
            
            [ud setBool:YES forKey:@"streamingHighQuality"];
            DLog(@"streamingHighQuality OFF");
            break;

        default:
            break;
    }

    [ud synchronize];
    
       [self postNotif];
    
}



-(IBAction)dismissModalController:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)viewDidUnload {
    use3gLabel = nil;
    streamingQualityLabel = nil;
    alwaysUseLowQualityLabel = nil;
    backButton = nil;
    [self setBackButton:nil];
    navBar = nil;
    [self setNavBar:nil];
    [super viewDidUnload];
}
@end
//
//  OptionsVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/13/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsVC : UITableViewController {
    
    IBOutlet UISwitch *threeG;
    
    IBOutlet UISwitch *alwaysUseLowQualityWhenOn3G;
    
    IBOutlet UISegmentedControl *quality;
    
    IBOutlet UILabel *use3gLabel;
    IBOutlet UILabel *streamingQualityLabel;
    IBOutlet UILabel *alwaysUseLowQualityLabel;
    
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UINavigationItem *navBar;
}



@property(nonatomic,retain)IBOutlet UISwitch *threeG;

@property(nonatomic,retain)IBOutlet UISwitch *alwaysUseLowQualityWhenOn3G;
@property(nonatomic,retain)IBOutlet UISegmentedControl *quality;


@property(nonatomic,retain)IBOutlet UILabel *use3gLabel;
@property(nonatomic,retain)IBOutlet UILabel *streamingQualityLabel;
@property(nonatomic,retain)IBOutlet UILabel *alwaysUseLowQualityLabel;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;

-(IBAction)didOnly3GToggled:(id)sender;
-(IBAction)didToggleQuality:(id)sender;

-(IBAction)dismissModalController:(id)sender;

@end

//
//  FirstViewController.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioPlayer.h"

@interface HomeVC : UIViewController <RadioPlayerDelegate>{
    
    IBOutlet UILabel *nowplaying;
    IBOutlet UILabel *metadatas;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIBarButtonItem *playButton;
    IBOutlet UIBarButtonItem *pauseButton;
    IBOutlet UIBarButtonItem *playButton2;
    IBOutlet UIBarButtonItem *stopButton;
    IBOutlet UIBarButtonItem *shareButton;
    IBOutlet UIBarButtonItem *flexible;
    IBOutlet UILabel *alaqsaUILabel;
    IBOutlet UINavigationBar *navBar2;
    
    RadioPlayer *radioPlayer;
    IBOutlet UIImageView* img;
}



@property (retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *pauseButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playButton2;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *stopButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexible;
@property (nonatomic,retain)  IBOutlet UIBarButtonItem *shareButton;
@property (strong, nonatomic) IBOutlet UILabel *alaqsaUILabel;
@property (nonatomic, retain) IBOutlet UILabel *nowplaying;
@property (nonatomic, retain) IBOutlet UILabel *metadatas;
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;


/* Radio player delegate methods -- these get called by RadioPlayer instance */ 

-(void)radioDidPause;
-(void)radioDidPlay;
-(void)radioDidStop;

-(void)setMetadata:(NSString *)metadata;
-(BOOL)getNowPlayingHiddenBool;
-(void)setNowPlayingHiddenBool:(BOOL)boolean;



    
@end

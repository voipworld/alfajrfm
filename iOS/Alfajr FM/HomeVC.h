//
//  FirstViewController.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK



#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

#import "URLS.h"

@class AVPlayer;
@class AVPlayerItem;


@interface HomeVC : UIViewController {
    
    AVAsset *asset;
    AVPlayerItem *playerItem;
    AVPlayer *player;
    NSURL *mURL;
    
    
	IBOutlet MPVolumeView *airplay;
    IBOutlet UILabel *nowplaying;
    IBOutlet UILabel *metadatas;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIBarButtonItem *playButton;
    IBOutlet UIBarButtonItem *pauseButton;
    IBOutlet UIBarButtonItem *playButton2;
    IBOutlet UIBarButtonItem *stopButton;
     IBOutlet UIBarButtonItem *shareButton;
    IBOutlet UIBarButtonItem *flexible;
   // IBOutlet UI
    
    //prefs
    
    BOOL use3G;
    BOOL streamingHighQuality;
    BOOL alwaysUseLowQualityWhenOn3G;
    
    
    IBOutlet UILabel *alaqsa;
  
    
    Reachability* internetReachable;
    Reachability* hostReachable;
 
    UIAlertView *alert;
    
    URLS *streamDefinitions;
    NSString *stream1;
    NSString *stream2;
    
    IBOutlet UINavigationBar *navBar2;
}
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;



@property (nonatomic) BOOL *allowsAirPlay;
@property(nonatomic,retain) IBOutlet MPVolumeView *airplay;

@property (nonatomic, retain) IBOutlet UILabel *nowplaying;
@property (nonatomic, retain) IBOutlet UILabel *metadatas;
@property (retain) IBOutlet UIToolbar *toolBar;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *playButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *pauseButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playButton2;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *stopButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexible;
@property (nonatomic,retain)  IBOutlet UIBarButtonItem *shareButton;

@property (nonatomic, assign) CMTime movieDuration;

@property (strong, nonatomic) IBOutlet UILabel *alaqsa;



- (void)observeValueForKeyPath:(NSString *)keyPath   ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context;
- (BOOL)isPlaying;
- (void)enablePlayerButtons;
- (void)disablePlayerButtons;


- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;

-(void)reachabilityDidChange:(NSNotification *) notif;
    
@end

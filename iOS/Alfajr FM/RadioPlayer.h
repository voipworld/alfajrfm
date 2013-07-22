//
//  RadioPlayer.h
//  Alfajr FM
//
//  Created by John Doe on 7/17/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK

#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

#import "URLS.h"



@class RadioPlayer;
@class AVPlayer;
@class AVPlayerItem;

@protocol RadioPlayerDelegate <NSObject>

@required

-(void)radioDidPause;
-(void)radioDidPlay;
-(void)radioDidStop;

-(void)setMetadata:(NSString *)metadata;
-(BOOL)getNowPlayingHiddenBool;
-(void)setNowPlayingHiddenBool:(BOOL)boolean;


@end




@interface RadioPlayer : NSObject {
    
    AVAsset *asset;
    AVPlayerItem *playerItem;
    AVPlayer *player;
    NSURL *mURL;

    //prefs
    
    BOOL use3G;
    BOOL streamingHighQuality;
    BOOL alwaysUseLowQualityWhenOn3G;
    
    
    Reachability* internetReachable;
    Reachability* hostReachable;

    
    URLS *streamDefinitions;
    NSString *stream1;
    NSString *stream2;
    
    
    UIAlertView *alert;
    
}

+ (RadioPlayer *)sharedInstance;
@property (nonatomic, weak) id <RadioPlayerDelegate> delegate;

#pragma mark -
#pragma mark highlevel API:

-(void)pauseRadio;
-(void)playRadio;
-(void)stopRadio;
-(void)togglePlayPause;


#pragma mark - 
#pragma mark Internals

-(void)reachabilityDidChange:(NSNotification *) notif;
-(void)observeValueForKeyPath:(NSString *)keyPath   ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context;
@property (nonatomic) BOOL *allowsAirPlay;
@property (nonatomic, assign) CMTime movieDuration;




@end

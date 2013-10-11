//
//  RadioPlayer.m
//  Alfajr FM
//
//  Created by John Doe on 7/17/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "RadioPlayer.h"

@implementation RadioPlayer

#pragma mark init

- (id)init {
    if (self = [super init]) {
        
        [self initMain];
        
    }
    return self;
}


+ (RadioPlayer *)sharedInstance
{
    static RadioPlayer *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[RadioPlayer alloc] init];
        
        return sharedInstance;
    }
}

#pragma mark
#pragma mark init radio

-(void)initMain{

    
    [self initNotifications];
    
    streamDefinitions = [URLS sharedInstance];
    
    stream1 = streamDefinitions.stream1;
    stream2 = streamDefinitions.stream2;
    
}


-(void)initNotifications{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeSettings:)
                                                 name:@"settingsToggled" object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName: @"www.apple.com"] ;
    [hostReachable startNotifier];
    
    
}



-(void)initPlayer:(NSString *)streamUrl {
    
    
    NSURL *url = [NSURL URLWithString:streamUrl];
    
    asset = nil;
    playerItem = nil;
    player = nil;
    
    asset = [AVURLAsset URLAssetWithURL:url options:nil];
    playerItem = [AVPlayerItem playerItemWithAsset:asset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [playerItem addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
    [player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // Allow to play in background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    player.allowsAirPlayVideo = YES;
player.allowsAirPlayVideo = NO;
    
    
} 



#pragma mark
#pragma mark high level instance methods


-(void)pauseRadio{
    
    [player pause];
    [self.delegate radioDidPause];
    
}



-(void)playRadio{
    
    
    if(player==nil){
        
        [self didChangeSettings:nil];
        //DLog(@"was stopped");
        
    } else {
        
        // DLog(@"was paused");
        
        
    }
    [player play];
    [self.delegate radioDidPlay];
    
}



-(void)stopRadio{
    
    [player pause];
    [self deallocPlayer];
    [self.delegate radioDidStop];
    
}


#pragma mark
#pragma mark aux

- (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


-(void)reachabilityDidChange:(NSNotification *) notif{
    
    
    
    DLog(@"");
    
    [self didChangeSettings:nil];
    
}


-(void)didChangeSettings:(NSNotification *)notif{
    
    DLog(@"");
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    use3G = [ud boolForKey:@"use3G"];
    alwaysUseLowQualityWhenOn3G = [ud boolForKey:@"alwaysUseLowQualityWhenOn3G"];
    streamingHighQuality = [ud boolForKey:@"streamingHighQuality"];
    
    BOOL _on3G ;
    BOOL _streamQualityHigh = streamingHighQuality;
    
    
    NetworkStatus currentStatus = [[Reachability reachabilityForInternetConnection]
                                   currentReachabilityStatus];
    
    NSString *statusString = [[NSString alloc] init];
    
    
    switch (currentStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
            _on3G = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            _on3G = YES;
            
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= @"Reachable WiFi";
            _on3G = NO;
            break;
        }
    }
    
    
    
    
    if([self connected]){
        
        if(alert != nil){
            
            [self dismissAlert:nil];
            
        }
        
        if(_on3G){
            
            DLog(@" on cellular\n\n\n");
            
            if(!use3G){
                
                //  [self stop:nil];
                
                alert = [[UIAlertView alloc] initWithTitle:@"On Cellular Network"
                                                   message:@"Radio disabled due to settings"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
                
                DLog(@"Radio disabled due to settings\n\n\n");
                
            } else {
                
                DLog(@"Everything is fine, on 3G and radio is allowed to play\n\n\n");
                
                if(alwaysUseLowQualityWhenOn3G) {
                    
                    _streamQualityHigh = NO;
                } else {
                    
                    _streamQualityHigh = streamingHighQuality;
                }
                
                [self initPlayerWithChangedURL:_streamQualityHigh];
                
            }
        }
        
        else {
            
            //DLog(@"not on 3g\n\n\n");
            
            // keep _stream quality as set to streamingHighQuality
            
            [self stopRadio];
            [self initPlayerWithChangedURL:streamingHighQuality];
            
        }
    } else {
        
        if(alert != nil){
            
            [self dismissAlert:nil];
            
        }
        
        DLog(@"no network");
        
        alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable"
                                           message:@"Please reconnect to the internet"
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        
        [self stopRadio];
        
    }
}


-(IBAction)dismissAlert:(id)sender {
    
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    alert = nil;
    
}


-(void)initPlayerWithChangedURL:(BOOL)highQualityON{
    
    if(highQualityON==YES){
        DLog(@"stream1");
        [self initPlayer:stream1];
        
    }else {
        
        DLog(@"stream2");
        
        [self initPlayer:stream2];
    }
    
}

-(bool)hasCellular {
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    bool found = false;
    
    
    
    if (getifaddrs(&addrs) == 0) {
        cursor = addrs;
        while (cursor != NULL) {
            NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
            if ([name isEqualToString:@"pdp_ip0"]) {
                found = true;
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return found;
}


- (void)togglePlayPause {
    if ([self isPlaying]) {
        
        [self pauseRadio];
        
    } else {
        
        [self playRadio];
    }
}


#pragma mark -

static Float64 secondsWithCMTimeOrZeroIfInvalid(CMTime time) {
    return CMTIME_IS_INVALID(time) ? 0.0f : CMTimeGetSeconds(time);
}




- (Float64)durationInSeconds {
    return secondsWithCMTimeOrZeroIfInvalid(self.movieDuration);
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *pItem = (AVPlayerItem *)object;
        if (pItem.status == AVPlayerItemStatusReadyToPlay) {
            //DLog(@"ready to play");
            [self.delegate setMetadata: @""];
    
        }
    }
    if ([keyPath isEqualToString:@"timedMetadata"] && [self isPlaying]) {
        for (AVAssetTrack *track in player.currentItem.tracks) {
            for (AVPlayerItemTrack *item in player.currentItem.tracks) {
                if ([item.assetTrack.mediaType isEqual:AVMediaTypeAudio]) {
                    NSArray *meta = [playerItem timedMetadata];
                    for (AVMetadataItem *metaItem in meta) {
                        if([self.delegate getNowPlayingHiddenBool] == YES) {
                            [self.delegate setNowPlayingHiddenBool:NO];
                        }
                        NSString *source = metaItem.stringValue;
                        char converted[([source length] + 1)];
                        [source getCString:converted maxLength:([source length] + 1) encoding: NSISOLatin1StringEncoding];
                        
                        NSString *converted_str = [NSString stringWithCString:converted encoding:NSUTF8StringEncoding];
                        DLog(@"meta %@",converted_str);
                        [self.delegate setMetadata: converted_str];
                                              
                    }
                }
            }
        }
    }
}

- (BOOL)isPlaying
{
    return [player rate] != 0.f;
}


-(void)deallocPlayer {
    
    
    [playerItem removeObserver:self forKeyPath:@"timedMetadata"];
    [player removeObserver:self forKeyPath:@"status"];
    
    asset = nil;
    playerItem = nil;
    player = nil;
    
}


@end

//
//  FirstViewController.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "HomeVC.h"


@interface HomeVC ()

@end

@implementation HomeVC

@synthesize playButton;
@synthesize playButton2;
@synthesize flexible;
@synthesize stopButton;
@synthesize shareButton;


@synthesize nowplaying, metadatas;
@synthesize toolBar, pauseButton;
@synthesize movieDuration;
@synthesize allowsAirPlay;
@synthesize airplay;

@synthesize alaqsa;
@synthesize navBar2;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initNotifications];
    [self initMisc];
    
    [self didChangeSettings:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMisc{
    
    self.alaqsa.text = @"";
    self.alaqsa = nil;
    
   // self.alaqsa.text = NSLocalizedString(@"alaqsa", nil);
    self.playButton.title = NSLocalizedString(@"Play", nil);
    self.stopButton.title = NSLocalizedString(@"Stop", nil);
    self.pauseButton.title = NSLocalizedString(@"Pause", nil);
    self.shareButton.title = NSLocalizedString(@"Share", nil);
  
    self.navBar2.topItem.title =  NSLocalizedString(@"HomeVCTitle", nil);
    self.title =  NSLocalizedString(@"HomeVCTitle", nil);
    
    streamDefinitions = [URLS sharedInstance];
    
    stream1 = streamDefinitions.stream1;
    stream2 = streamDefinitions.stream2;
    
    
}
- (void)awakeFromNib
{
    self.title =  NSLocalizedString(@"HomeVCTitle", nil);
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
    streamingHighQuality = [ud boolForKey:@"alwaysUseLowQualityWhenOn3G"];
    alwaysUseLowQualityWhenOn3G = [ud boolForKey:@"streamingHighQuality"];
    
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
                    
                    _streamQualityHigh = YES;
                }
            
                [self initPlayerWithChangedURL:_streamQualityHigh];
        
            }
        }
        
         else {
            
             //DLog(@"not on 3g\n\n\n");
            
             // keep _stream quality as set to streamingHighQuality
             
             [self stop:nil];
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
        
        [self stop:nil];
        
    }
}


-(IBAction)dismissAlert:(id)sender {
    
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    alert = nil;
    
}


-(void)initPlayerWithChangedURL:(BOOL)highQualityON{
    
    if(highQualityON){
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



#pragma mark -
#pragma mark Aux


-(void)initPlayer:(NSString *)streamUrl {
    
    
    nowplaying.hidden = YES;
    metadatas.text = NSLocalizedString(@"loading", nil);
    
    [self.airplay setShowsVolumeSlider:YES];
    [self.airplay setShowsRouteButton:YES];
   	
    self.airplay.backgroundColor = [UIColor clearColor];
    
    NSURL *url = [NSURL URLWithString:streamUrl];
    
    asset = [AVURLAsset URLAssetWithURL:url options:nil];
    playerItem = [AVPlayerItem playerItemWithAsset:asset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [playerItem addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
    [player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    ////////////
    
    
    
    // Override point for customization after application launch.
    
    // Allow to play in background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    
    [self play:nil];
    

} 



#pragma mark - 
#pragma mark Aux



static Float64 secondsWithCMTimeOrZeroIfInvalid(CMTime time) {
    return CMTIME_IS_INVALID(time) ? 0.0f : CMTimeGetSeconds(time);
}




- (Float64)durationInSeconds {
    return secondsWithCMTimeOrZeroIfInvalid(self.movieDuration);
}




//- (void)handleDurationDidChange {
//    movieDuration = player.currentItem.duration;
//    DLog(@"current duration : %@", movieDuration);
//}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *pItem = (AVPlayerItem *)object;
        if (pItem.status == AVPlayerItemStatusReadyToPlay) {
            //NSLog(@"ready to play");
            metadatas.text = @"";
            //[self playpause];
        }
    }
    if ([keyPath isEqualToString:@"timedMetadata"] && [self isPlaying]) {
        for (AVAssetTrack *track in player.currentItem.tracks) {
            for (AVPlayerItemTrack *item in player.currentItem.tracks) {
                if ([item.assetTrack.mediaType isEqual:AVMediaTypeAudio]) {
                    NSArray *meta = [playerItem timedMetadata];
                    for (AVMetadataItem *metaItem in meta) {
                        if(nowplaying.hidden == YES) {
                            nowplaying.hidden = NO;
                        }
                        NSString *source = metaItem.stringValue;
                        char converted[([source length] + 1)];
                        [source getCString:converted maxLength:([source length] + 1) encoding: NSISOLatin1StringEncoding];
                        
                        NSString *converted_str = [NSString stringWithCString:converted encoding:NSUTF8StringEncoding];
                        NSLog(@"meta %@",converted_str);
                        metadatas.text = converted_str;
                       // [metadatas sizeToFit];
                        // metadatas.textAlignment = UITextAlignmentCenter;
                        metadatas.textAlignment = NSTextAlignmentCenter;
                        
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




- (void)enablePlayerButtons
{
    self.playButton.enabled = YES;
    self.pauseButton.enabled = YES;
}

- (void)disablePlayerButtons
{
    self.playButton.enabled = NO;
    self.pauseButton.enabled = NO;
}


#pragma mark -
#pragma mark Actions


- (IBAction)play:(id)sender {
    
    if(player==nil){
        
        [self didChangeSettings:nil];
        //DLog(@"was stopped");
        
    } else {
        
       // DLog(@"was paused");
        [player play];
        
        [self setButtonsForPlayingState];
        
    }
    
       
}

- (IBAction)pause:(id)sender{
    
    [player pause];

    [self setButtonsForPausedState];
    
    
}



-(IBAction)stop:(id)sender{
    
    nowplaying.hidden = YES;
    metadatas.text = NSLocalizedString(@"stopped", nil);
    
    
     [player pause];
    [self setButtonsForStoppedState];
    
    [self deallocPlayer];
    
    
}

-(void)deallocPlayer {
    
    
    [playerItem removeObserver:self forKeyPath:@"timedMetadata"];
    [player removeObserver:self forKeyPath:@"status"];
    
    [self.airplay setShowsVolumeSlider:NO];
    [self.airplay setShowsRouteButton:NO];
    
    
    asset = nil;
    playerItem = nil;
    player = nil;
     
}

-(void)setButtonsForPlayingState{
    
    NSMutableArray *newToolBarArray = [[NSMutableArray alloc] init];
    [newToolBarArray addObject:self.pauseButton];
    [newToolBarArray addObject:self.stopButton];
    [newToolBarArray addObject:self.flexible];
    [newToolBarArray addObject:self.shareButton];
    
    
    
    
    NSArray *finalTabBarArray =[[NSArray alloc] initWithObjects:newToolBarArray, nil];
    [toolBar setItems:[finalTabBarArray objectAtIndex:0] animated:NO];
    

}

-(void)setButtonsForPausedState{
    
    
    NSMutableArray *newToolBarArray = [[NSMutableArray alloc] init];
    [newToolBarArray addObject:self.playButton];
    [newToolBarArray addObject:self.stopButton];
    [newToolBarArray addObject:self.flexible];
    [newToolBarArray addObject:self.shareButton];
    
    NSArray *finalTabBarArray =[[NSArray alloc] initWithObjects:newToolBarArray, nil];
    [toolBar setItems:[finalTabBarArray objectAtIndex:0] animated:NO];
    
    
}

-(void)setButtonsForStoppedState {
    
    
    NSMutableArray *newToolBarArray = [[NSMutableArray alloc] init];
    [newToolBarArray addObject:self.playButton];
    [newToolBarArray addObject:self.flexible];
    //[newToolBarArray addObject:self.shareButton];
    
    NSArray *finalTabBarArray =[[NSArray alloc] initWithObjects:newToolBarArray, nil];
    [toolBar setItems:[finalTabBarArray objectAtIndex:0] animated:NO];
    
    
}


#pragma mark -


- (IBAction)didTouchUpInsideShare:(id)sender
{

    NSString *textToShare = [NSString stringWithFormat:@"Listening to %@ on AlfajrFM", metadatas.text];
    
    UIImage *imageToShare = [UIImage imageNamed:@"Alaqsa_small.jpg"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.alfajrfm.com/"];
    NSArray *activityItems = @[textToShare,imageToShare,  urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:Nil];
    
    
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}



-(BOOL)canBecomeFirstResponder {
    return YES;
}




- (void)viewDidUnload
{
    self.toolBar = nil;
    self.playButton = nil;
    self.pauseButton = nil;
    self.nowplaying = nil;
    self.metadatas = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    alaqsa = nil;
    [self setAlaqsa:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end

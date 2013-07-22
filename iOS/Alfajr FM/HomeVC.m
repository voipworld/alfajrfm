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

@synthesize alaqsaUILabel;
@synthesize navBar2;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initMisc];
    [self initRadioPlayer];
    
}



-(void)initMisc{
    
    self.alaqsaUILabel.text = @"";
    self.alaqsaUILabel = nil;
    
   // self.alaqsa.text = NSLocalizedString(@"alaqsa", nil);
    self.playButton.title = NSLocalizedString(@"Play", nil);
    self.stopButton.title = NSLocalizedString(@"Stop", nil);
    self.pauseButton.title = NSLocalizedString(@"Pause", nil);
    self.shareButton.title = NSLocalizedString(@"Share", nil);
  
    self.navBar2.topItem.title =  NSLocalizedString(@"HomeVCTitle", nil);
    self.title =  NSLocalizedString(@"HomeVCTitle", nil);
   
    self.metadatas.textAlignment = NSTextAlignmentCenter;
}

-(void)initRadioPlayer {
    
    nowplaying.hidden = YES;
    metadatas.text = NSLocalizedString(@"loading", nil);
    
    
    radioPlayer = [RadioPlayer sharedInstance];
    [radioPlayer setDelegate:self];
    
}



#pragma mark -
#pragma mark Delegate methods

-(void)radioDidPause{
    
    DLog(@"");
    [self setButtonsForPausedState];
    
}


-(void)radioDidPlay{
    
    DLog(@"");
    [self setButtonsForPlayingState];
    
}

-(void)radioDidStop{
    DLog(@"");
    nowplaying.hidden = YES;
    metadatas.text = NSLocalizedString(@"stopped", nil);
    
    [self setButtonsForStoppedState];
    
}

//getter and setter methods to access HomeViewContontroller's properties

-(void)setMetadata:(NSString *)metadata{
    
    metadatas.text = metadata;
    
    
}
-(BOOL)getNowPlayingHiddenBool{
    
    return nowplaying.hidden;
}


-(void)setNowPlayingHiddenBool:(BOOL)boolean{
    
    nowplaying.hidden = boolean;
    
}

#pragma mark -
#pragma mark Background gestures


//background gestures only work with UIViewControllers. Do not use background gestures with an NSObject subclass such as the radio player because they do not register for some reason. Sorry.


-(void)startBackgroundGestures {

    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

-(void)endBackgroundGestures {
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    DLog(@"");
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlTogglePlayPause:
            [radioPlayer togglePlayPause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            break;
        default:
            break;
    }
}

//http://stackoverflow.com/questions/6843309/remotecontrolreceivedwithevent-in-avaudio-is-not-being-called
// it needs to become first responder to recieve bg gestures

- (BOOL)canBecomeFirstResponder {
    DLog(@"");
    return YES;
}



#pragma mark -
#pragma mark Actions


- (IBAction)play:(id)sender {
        
    [radioPlayer playRadio];
    
}

- (IBAction)pause:(id)sender{
    
    [radioPlayer pauseRadio];
}



-(IBAction)stop:(id)sender{
    
    [radioPlayer stopRadio];
}



#pragma mark -
#pragma mark Update UI

-(void)setButtonsForPlayingState{
    
    NSMutableArray *newToolBarArray = [[NSMutableArray alloc] init];
    [newToolBarArray addObject:self.pauseButton];
    [newToolBarArray addObject:self.stopButton];
    [newToolBarArray addObject:self.flexible];
    [newToolBarArray addObject:self.shareButton];
    
    NSArray *finalTabBarArray =[[NSArray alloc] initWithObjects:newToolBarArray, nil];
    [toolBar setItems:[finalTabBarArray objectAtIndex:0] animated:NO];
    

}

-(void)setButtonsForPausedState {
    
    
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


- (IBAction)share:(id)sender {

    NSString *textToShare = [NSString stringWithFormat:@"Listening to %@ on AlfajrFM", metadatas.text];
    
    UIImage *imageToShare = [UIImage imageNamed:@"Alaqsa_small.jpg"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.alfajrfm.com/"];
    NSArray *activityItems = @[textToShare,imageToShare,  urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:Nil];
    
    
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}


#pragma mark - 
#pragma mark View Lifecycle


- (void)awakeFromNib {
    
    self.title =  NSLocalizedString(@"HomeVCTitle", nil);
}



- (void)viewDidUnload {
    
    self.toolBar = nil;
    self.playButton = nil;
    self.pauseButton = nil;
    self.nowplaying = nil;
    self.metadatas = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    alaqsaUILabel = nil;
    [self setAlaqsaUILabel:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startBackgroundGestures];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self endBackgroundGestures];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end

//
//  AppDelegate.m
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


-(void)loadMainView {
	// this was used to switch from the starting/buffering view to the now playing view, see the "Radio Javan" app in the App Store for how that works
}

-(void)updateTitle:(NSString*)title {
	// update view text
}

-(void)updateGain:(float)value {
	// update volume slider
}

-(void)updatePlay:(BOOL)play {
	// toggle play/pause button
}

-(void)updateBuffering: (BOOL)value {
	// update buffer indicator
}



- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if([ud objectForKey:@"use3G"] == nil) {
        
        [ud setBool:YES forKey:@"use3G"];
        
        
        [ud setBool:YES forKey:@"streamingHighQuality"];
      
        
        [ud setBool:YES forKey:@"alwaysUseLowQualityWhenOn3G"];
        
        DLog(@"first time");
        

        [ud synchronize];
        
    }
        
    
	[_window makeKeyAndVisible];

}



@end

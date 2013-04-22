//
//  StreamDefinitions.m
//  Alfajr FM
//
//  Created by John Doe on 4/22/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "StreamDefinitions.h"

#define stream11 @"http://live.vobradio.org:8000/live" //highquality
#define stream22 @"http://live.vobradio.org:8000/live24"




@implementation StreamDefinitions


@synthesize stream1;
@synthesize stream2;

- (id)init {
    if (self = [super init]) {

        self.stream1 = stream11;
        self.stream2 = stream22;
        
        DLog(@"YES");
    
    }
    return self;
}

@end

//
//  StreamDefinitions.m
//  Alfajr FM
//
//  Created by John Doe on 4/22/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import "URLS.h"

//#define stream11 @"http://live.vobradio.org:8000/live" //highquality
//#define stream22 @"http://live.vobradio.org:8000/live24"

#define stream11 @"http://live.atyaf.co:8008/;stream" //highquality
#define stream22 @"http://s2.voscast.com:7716"


#define kNEWS_URL @"http://www.alfajrfm.com/news/"
#define kPROGRAM_URL @"http://www.alfajrfm.com/"

#define kURLTwitter @"http://twitter.com/radioalresalah"
#define kURLFacebook @"http://facebook.com/alfajrfm"





@implementation URLS

static URLS* _sharedInstance = nil;

+(URLS*)sharedInstance
{
	@synchronized([URLS class])
	{
		if (!_sharedInstance)
			[[self alloc] init];
        
		return _sharedInstance;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([URLS class])
	{
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedInstance = [super alloc];
		return _sharedInstance;
	}
    
	return nil;
}


@synthesize stream1;
@synthesize stream2;

@synthesize facebook;
@synthesize twitter;

@synthesize program;
@synthesize news;


- (id)init {
    if (self =  [super init]) {

        self.stream1 = stream11;
        self.stream2 = stream22;
        
        self.facebook = kURLFacebook;
        self.twitter = kURLTwitter;
        
        self.program = kPROGRAM_URL;
        self.news = kNEWS_URL;
        
        DLog(@"YES");
    
    }
    return self;
}

@end

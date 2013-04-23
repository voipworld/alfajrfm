//
//  StreamDefinitions.h
//  Alfajr FM
//
//  Created by John Doe on 4/22/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLS : NSObject {
    
    NSString *stream1;
    NSString *stream2;
    
    
    NSString *facebook;
    NSString *twitter;
    
    NSString *program;
    NSString *news;
}

+(URLS*)sharedInstance;

@property(nonatomic,retain)NSString *stream1;
@property(nonatomic,retain)NSString *stream2;

@property(nonatomic,retain)NSString *facebook;
@property(nonatomic,retain)NSString *twitter;

@property(nonatomic,retain)NSString *program;
@property(nonatomic,retain)NSString *news;

@end

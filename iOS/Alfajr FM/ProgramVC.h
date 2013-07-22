//
//  ProgramVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLS.h"

@interface ProgramVC : UIViewController {
    
    
    IBOutlet UIWebView *programWebview;
    
    IBOutlet UINavigationBar *navBar2;
}
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;


@property(nonatomic,retain)IBOutlet UIWebView *programWebview;



@end

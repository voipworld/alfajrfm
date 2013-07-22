//
//  ContactVC.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLS.h"

@interface NewsVC : UIViewController {

    IBOutlet UIWebView *newsWebview;
    IBOutlet UINavigationBar *navBar2;
}
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;

@property(nonatomic,retain)IBOutlet UIWebView *newsWebview;


@end
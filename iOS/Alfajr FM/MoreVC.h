//
//  MoreVC.h
//  Alfajr FM
//
//  Created by John Doe on 4/22/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreVC : UIViewController {
  
    IBOutlet UINavigationBar *navBar2;
    IBOutlet UIButton *about;
    IBOutlet UIButton *settings;
    
}

@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;
@property(nonatomic,retain)IBOutlet UIButton *about;
@property(nonatomic,retain)IBOutlet UIButton *settings;


@end

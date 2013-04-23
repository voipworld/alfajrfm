//
//  SecondViewController.h
//  Alfajr FM
//
//  Created by John Doe on 3/12/13.
//  Copyright (c) 2013 Alfajr FM. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SocialVC : UIViewController {
    
    IBOutlet UINavigationBar *navBar2;
    
    IBOutlet UIButton *facebook;
    IBOutlet UIButton *twitter;
    
}
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar2;

@property(nonatomic,retain)IBOutlet UIButton *facebook;

@property(nonatomic,retain)IBOutlet UIButton *twitter;



@end

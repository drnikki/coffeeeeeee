//
//  AppDelegate.h
//  CoffeeSVP
//
//  Created by bmaci on 1/9/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntroViewController;
@class BaristaStatusViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IntroViewController *introViewController;
@property (strong, nonatomic) BaristaStatusViewController *baristaStatusViewController;

- (void)showIntroViewController;
- (void)showStatusViewController;

@end

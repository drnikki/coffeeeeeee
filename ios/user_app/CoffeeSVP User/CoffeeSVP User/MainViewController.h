//
//  MainViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 1/29/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppUtilities.h"
#import "ConnectionManager.h"
#import "OrderViewController.h"
#import "StatusViewController.h"
#import "HistoryViewController.h"
#import "GlossaryViewController.h"
#import "GalleryViewController.h"
#import "LoadingViewController.h"
#import "MainViewTabNavigationView.h"
#import "ToggleView.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) OrderViewController *orderViewController;
@property (strong, nonatomic) StatusViewController *statusViewController;
@property (strong, nonatomic) HistoryViewController *historyViewController;
@property (strong, nonatomic) GlossaryViewController *glossaryViewController;
@property (strong, nonatomic) GalleryViewController *galleryViewController;
@property (strong, nonatomic) LoadingViewController *loadingViewController;

@property (strong, nonatomic) NSUserDefaults *prefs;

@property (strong, nonatomic) IBOutlet MainViewTabNavigationView *tabsNavView;
@property (strong, nonatomic) IBOutlet UIView *tabsContainer;

@end

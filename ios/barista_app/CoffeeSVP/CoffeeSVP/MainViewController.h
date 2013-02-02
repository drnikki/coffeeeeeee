//
//  MainViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/10/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToggleView.h"
#import "BaristaStatusViewController.h"
#import "GalleryViewController.h"
#import "SettingsViewController.h"
#import "StatsViewController.h"
#import "LoadingViewController.h"
#import "QueueViewController.h"
#import "SpecialInstructionsViewController.h"

#define queueSlug @"queue"
#define settingsSlug @"settings"
#define statsSlug @"stats"
#define gallerySlug @"gallery"

@interface MainViewController : UIViewController <QueueViewControllerDelegate, BaristaStatusViewControllerDelegate, GalleryViewControllerDelegate>

@property (strong, nonatomic) BaristaStatusViewController *baristaStatusViewController;
@property (strong, nonatomic) QueueViewController *queueViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) StatsViewController *statsViewController;
@property (strong, nonatomic) LoadingViewController *loadingViewController;
@property (strong, nonatomic) SpecialInstructionsViewController *specialInstructionsViewController;
@property (strong, nonatomic) GalleryViewController *galleryViewController;

@property (strong, nonatomic) ToggleView *queueButton;
@property (strong, nonatomic) ToggleView *settingsButton;
@property (strong, nonatomic) ToggleView *statsButton;
@property (strong, nonatomic) ToggleView *galleryButton;

@property (strong, nonatomic) NSUserDefaults *prefs;

@property (strong, nonatomic) IBOutlet UIView *tabContainer;

- (void)initStatusViewController;
- (void)loadTabView:(NSString *)tabName;

@end

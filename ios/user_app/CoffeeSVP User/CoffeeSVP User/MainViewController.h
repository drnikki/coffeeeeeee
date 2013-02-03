//
//  MainViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 1/29/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectionManager.h"
#import "OrderViewController.h"
#import "StatusViewController.h"
#import "HistoryViewController.h"
#import "GlossaryViewController.h"
#import "GalleryViewController.h"
#import "ToggleView.h"

#define orderSlug @"order"
#define statusSlug @"status"
#define historySlug @"history"
#define glossarySlug @"glossary"
#define gallerySlug @"gallery"

#define verticalTabX0 6.0f
#define verticalTabY0 28.0f
#define verticalTabWidth 74.0f
#define verticalTabHeight 74.0f

@interface MainViewController : UIViewController

@property (strong, nonatomic) OrderViewController *orderViewController;
@property (strong, nonatomic) StatusViewController *statusViewController;
@property (strong, nonatomic) HistoryViewController *historyViewController;
@property (strong, nonatomic) GlossaryViewController *glossaryViewController;
@property (strong, nonatomic) GalleryViewController *galleryViewController;
//@property (strong, nonatomic) LoadingViewController *loadingViewController;

@property (strong, nonatomic) ToggleView *orderButton;
@property (strong, nonatomic) ToggleView *statusButton;
@property (strong, nonatomic) ToggleView *historyButton;
@property (strong, nonatomic) ToggleView *glossaryButton;
@property (strong, nonatomic) ToggleView *galleryButton;

@property (strong, nonatomic) NSUserDefaults *prefs;

@property (strong, nonatomic) IBOutlet UIView *tabsContainer;

- (void)loadTabView:(NSString *)tabName;

@end

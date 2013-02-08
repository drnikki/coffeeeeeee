//
//  MainViewTabNavigationView.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUtilities.h"
#import "ToggleView.h"

#define verticalTabX0 0.0f
#define verticalTabY0 0.0f
#define verticalTabWidth 74.0f
#define verticalTabHeight 74.0f

@interface MainViewTabNavigationView : UIView

@property (strong, nonatomic) ToggleView *orderButton;
@property (strong, nonatomic) ToggleView *statusButton;
@property (strong, nonatomic) ToggleView *historyButton;
@property (strong, nonatomic) ToggleView *glossaryButton;
@property (strong, nonatomic) ToggleView *galleryButton;

- (void)initVerticalTabButtons;

- (void)tabOrderClick:(id)sender;
- (void)tabStatusClick:(id)sender;
- (void)tabHistoryClick:(id)sender;
- (void)tabGlossaryClick:(id)sender;
- (void)tabGalleryClick:(id)sender;

@end

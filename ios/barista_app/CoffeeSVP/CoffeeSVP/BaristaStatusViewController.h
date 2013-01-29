//
//  BaristaStatusViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "ToggleView.h"

#define alertTitle @"Oh haaay!"

#define alertOpen @"Are you sure you wish to open the store?"
#define alertClosed @"Are you sure you wish to closed the store?"
#define alertBreak @"Are you sure you wish to go on break?"
#define alertBreakReturn @"Are you sure you're ready to return from your break and open up shop?"

#define statusOpen @"open"
#define statusClose @"closed"
#define statusBreak @"on_break"

@protocol BaristaStatusViewControllerDelegate <NSObject>
- (void)showLoadingView:(BOOL)on;
- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label;
@end

@interface BaristaStatusViewController : UIViewController
<UIAlertViewDelegate>

@property (assign) id <BaristaStatusViewControllerDelegate> delegate;

@property BOOL alertHasShown;
@property (strong, nonatomic) ToggleView *powerButton;
@property (strong, nonatomic) RCSwitchOnOff *onBreakSwitch;
@property (strong, nonatomic) IBOutlet UILabel *onBreakSwitchLabel;

@end

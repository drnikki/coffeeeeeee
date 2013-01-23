//
//  BaristaStatusViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

#define alertTitle @"Oh haaay!"

#define alertOpen @"Are you sure you wish to open the store?"
#define alertClosed @"Are you sure you wish to closed the store?"
#define alertBreak @"Are you sure you wish to go on break?"

#define statusOpen @"open"
#define statusClose @"closed"
#define statusBreak @"on_break"

@interface BaristaStatusViewController : UIViewController
<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *openButton;
@property (strong, nonatomic) IBOutlet UIButton *closedButton;
@property (strong, nonatomic) IBOutlet UIButton *onBreakButton;

@property (strong, nonatomic) IBOutlet UIImageView *openOn;
@property (strong, nonatomic) IBOutlet UIImageView *closedOn;
@property (strong, nonatomic) IBOutlet UIImageView *onBreakOn;

- (IBAction)openStore:(id)sender;
- (IBAction)closeStore:(id)sender;
- (IBAction)onBreakStore:(id)sender;

@end

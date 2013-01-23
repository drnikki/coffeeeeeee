//
//  QueueViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/12/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

#define alertCompleteTitle @"DRINK COMPLETE"
#define alertFlagTitle @"DRINK FLAG"

#define rotationLimit 1.5f

#define alertCompleteBody @"Do you confirm you have completed the drink for %@?"
#define alertFlagBody @"Do you confirm there is a problem with the drink for %@?"

@interface QueueViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic) float gaugeRotation;
@property (nonatomic) float totalRotation;
@property (nonatomic) float warningAlpha;

@property (nonatomic, strong) IBOutlet UIView *needleView;
@property (nonatomic, strong) UIView *dynamicNeedleView;
@property (nonatomic, strong) UIImageView *dynamicNeedle;
@property (nonatomic, strong) UIImageView *dynamicNeedleBusy;

// order item vars
@property (nonatomic, strong) IBOutlet UILabel *currentName;
@property (nonatomic, strong) IBOutlet UILabel *currentOrder;

@property (nonatomic, strong) IBOutlet UIButton *notesButton;
@property (nonatomic, strong) IBOutlet UITableView *upcomingOrderFeed;

@property (nonatomic, strong) IBOutlet UIView *loadingView;

@property (nonatomic, strong) IBOutlet UIView *currentOrderView;
@property (nonatomic, strong) IBOutlet UIImageView *queueEmptyView;

// special instructions view
@property (nonatomic, strong) IBOutlet UIView *notesView;
@property (nonatomic, strong) IBOutlet UILabel *notesName;
@property (nonatomic, strong) IBOutlet UILabel *notesOrder;

- (IBAction)gaugeDown:(id)sender;
- (IBAction)gaugeUp:(id)sender;

- (IBAction)drinkComplete:(id)sender;
- (IBAction)drinkFlag:(id)sender;

- (IBAction)viewNote:(id)sender;

@end

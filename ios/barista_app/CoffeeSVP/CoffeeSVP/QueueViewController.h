//
//  QueueViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/12/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

#define alertCompleteTitle @"DRINK COMPLETE"
#define alertFlagTitle @"DRINK FLAG"

#define rotationLimit 1.3f

#define alertCompleteBody @"Do you confirm you have completed the drink for %@?"
#define alertFlagBody @"Do you confirm there is a problem with the drink for %@?"

@protocol QueueViewControllerDelegate <NSObject>
- (void)showLoadingView:(BOOL)on;
- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label;
- (void) updateNotesView:(Order *)thisOrder;
- (void) hideNotesView:(NSNotification *)notification;
@end

@interface QueueViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (assign) id <QueueViewControllerDelegate> delegate;

@property (nonatomic, strong) NSTimer *loopTimer;

@property (nonatomic) float gaugeRotation;
@property (nonatomic) float totalRotation;
@property (nonatomic) float warningAlpha;

@property (nonatomic, strong) IBOutlet UIView *dynamicValuesView;

@property (nonatomic, strong) IBOutlet UIView *needleView;
@property (nonatomic, strong) UIView *dynamicNeedleView;
@property (nonatomic, strong) UIImageView *dynamicNeedle;
@property (nonatomic, strong) UIImageView *dynamicNeedleBusy;

@property (nonatomic, strong) IBOutlet UILabel *queueTotal;

// order item vars
@property (nonatomic, strong) IBOutlet UILabel *currentName;
@property (nonatomic, strong) IBOutlet UILabel *currentOrder;

@property (nonatomic, strong) IBOutlet UIButton *notesButton;
@property (nonatomic, strong) IBOutlet UITableView *upcomingOrderFeed;

@property (nonatomic, strong) IBOutlet UIView *currentOrderView;
@property (nonatomic, strong) IBOutlet UIImageView *queueEmptyView;

// user prefs
@property (nonatomic, strong) NSUserDefaults *prefs;

- (IBAction)gaugeDown:(id)sender;
- (IBAction)gaugeUp:(id)sender;

- (IBAction)drinkComplete:(id)sender;
- (IBAction)drinkFlag:(id)sender;

- (IBAction)viewNote:(id)sender;

@end

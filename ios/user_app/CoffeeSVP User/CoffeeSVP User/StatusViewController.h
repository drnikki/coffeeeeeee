//
//  StatusViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "StatusOpenOrderCell.h"

@protocol StatusViewControllerDelegate <NSObject>
- (void)showLoadingView:(BOOL)on;
- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label;
- (void)loadTabView:(NSString *)tabName;
- (void)loadTabView:(NSString *)tabName withNavUpdate:(BOOL)updateNav;
@end

@interface StatusViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (assign) id delegate;
@property (nonatomic, strong) IBOutlet UITableView *statusFeed;
@property (nonatomic, strong) IBOutlet UIView *emptyStatusView;

@property (nonatomic, strong) NSTimer *loopTimer;
@property (nonatomic, strong) NSUserDefaults *prefs;

- (IBAction)goToOrder:(id)sender;

@end

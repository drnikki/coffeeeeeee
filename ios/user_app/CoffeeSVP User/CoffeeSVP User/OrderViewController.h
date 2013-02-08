//
//  OrderViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMenuDefaultView.h"

@protocol OrderViewControllerDelegate <NSObject>
- (void)showLoadingView:(BOOL)on;
- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label;
- (void)loadTabView:(NSString *)tabName;
- (void)loadTabView:(NSString *)tabName withNavUpdate:(BOOL)updateNav;
@end

@interface OrderViewController : UIViewController

@property (assign) id <OrderViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet OrderMenuDefaultView *orderMenuDefaultView;

- (void)submitOrder:(BOOL)isSending;
- (void)goToTab:(NSString *)slug;

@end

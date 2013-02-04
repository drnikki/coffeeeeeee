//
//  OrderViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderConfirmView.h"
#import "OrderMenuDefaultView.h"

@interface OrderViewController : UIViewController

@property (strong, nonatomic) IBOutlet OrderConfirmView *orderConfirmView;
@property (strong, nonatomic) IBOutlet OrderMenuDefaultView *orderMenuDefaultView;

@end

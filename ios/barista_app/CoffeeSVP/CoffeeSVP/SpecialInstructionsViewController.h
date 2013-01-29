//
//  SpecialInstructionsViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/29/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface SpecialInstructionsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *notesBox;

@property (nonatomic, strong) IBOutlet UIView *notesView;
@property (nonatomic, strong) IBOutlet UILabel *notesName;
@property (nonatomic, strong) IBOutlet UILabel *notesOrder;

@property (nonatomic, strong) IBOutlet UIButton *flagDrinkButton;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) Order *data;

@end

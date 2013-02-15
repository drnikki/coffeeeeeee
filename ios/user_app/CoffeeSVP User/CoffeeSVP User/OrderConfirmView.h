//
//  OrderConfirmView.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenOrder.h"

@interface OrderConfirmView : UIView

@property (nonatomic, strong) IBOutlet UILabel *itemDate;
@property (nonatomic, strong) IBOutlet UILabel *itemName;
@property (nonatomic, strong) IBOutlet UILabel *itemNotes;
@property (nonatomic, strong) IBOutlet UILabel *itemPerson;

@property (nonatomic, strong) IBOutlet UIButton *createAnotherButton;
@property (nonatomic, strong) IBOutlet UIButton *gotoStatusButton;

- (void)showView:(BOOL)visible;
- (void)showView:(BOOL)visible withData:(OpenOrder *)data;


@end

//
//  UpcomingOrderCell.h
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

#define alertCompleteTitle @"DRINK COMPLETE"
#define alertFlagTitle @"DRINK FLAG"

#define alertCompleteBody @"Do you confirm you have completed the drink for %@?"
#define alertFlagBody @"Do you confirm there is a problem with the drink for %@?"

@interface UpcomingOrderCell : UITableViewCell
<UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *itemLabel;
@property (nonatomic, strong) IBOutlet UIButton *notesButton;
@property (nonatomic, strong) IBOutlet UIImageView *priority;

@property (nonatomic, strong) Order *thisOrder;
@property (nonatomic) int queuePosition;

- (IBAction)drinkComplete:(id)sender;
- (IBAction)drinkFlag:(id)sender;

- (IBAction)viewNote:(id)sender;

@end

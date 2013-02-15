//
//  StatusOpenOrderCell.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/6/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "OpenOrder.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface StatusOpenOrderCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *dynamicDial;
@property (nonatomic, strong) IBOutlet UIView *detailsView;
@property (nonatomic, strong) UIImageView *dialImage;
@property (nonatomic, strong) IBOutlet UIView *queuePlaceView;
@property (nonatomic, strong) IBOutlet UILabel *queuePlaceLabel;

- (void)setData:(OpenOrder *)data;

@end

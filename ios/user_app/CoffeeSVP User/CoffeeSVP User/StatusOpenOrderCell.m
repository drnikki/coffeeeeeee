//
//  StatusOpenOrderCell.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/6/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "StatusOpenOrderCell.h"

@implementation StatusOpenOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(OpenOrder *)data
{
    [self resetView];
    //set order item + wait time
    UILabel *title = [self addLabel:[NSString stringWithFormat:@"%@: ", [data orderItem]] atX:20 atY:10 inFont:@"HelveticaNeue-Medium" atFontSize:12.0f];
    UILabel *wait = [self addLabel:[NSString stringWithFormat:@"≈%imin", (int)[data waitTime]] atX:(20 + title.frame.size.width) atY:10 inFont:@"HelveticaNeue" atFontSize:12.0f];
    
    [self.detailsView addSubview:title];
    [self.detailsView addSubview:wait];
    
    //set queue place and center
    [self.queuePlaceLabel setText:[NSString stringWithFormat:@"%i", [data queuePlace]]];
    [self.queuePlaceLabel sizeToFit];
    
    [self resizeToFitSubviews:self.queuePlaceView];
    
    CGRect centerFrame = self.queuePlaceView.frame;
    
    centerFrame.origin.x = (self.frame.size.width - self.queuePlaceView.frame.size.width)/2.0f;
    
    self.queuePlaceView.frame = centerFrame;
    
    //set dynamic dial
    self.dialImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"status_dial_indicator.png"]];
    self.dialImage.frame = CGRectMake(0, 0, 80, 80);
    [self.dynamicDial addSubview:self.dialImage];
    
    //set rotation
    self.dynamicDial.transform = CGAffineTransformRotate(self.dynamicDial.transform,DEGREES_TO_RADIANS(340*((1 - (float)[data queuePlace]/(float)[ConnectionManager shareInstance].queueTotal)) + 20));
    NSLog(@"queueTotal: %i", [ConnectionManager shareInstance].queueTotal);
}

-(void)resetView
{
    for (UIView *v in [self.detailsView subviews]) {
        [v removeFromSuperview];
    }
    
    for (UIView *v in [self.dynamicDial subviews])
    {
        [v removeFromSuperview];
    }
    
    self.dynamicDial.transform = CGAffineTransformIdentity;
}

- (UILabel *)addLabel:(NSString *)copy atX:(float)x atY:(float)y inFont:(NSString *)fontName atFontSize:(float)fontSize
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 21)];
    
    [t setNumberOfLines:1];
    [t setBackgroundColor:[UIColor clearColor]];
    [t setTextAlignment:NSTextAlignmentLeft];
    [t setTextColor:[UIColor colorWithRed:(41.0f/255.0f) green:(41.0f/255.0f) blue:(41.0f/255.0f) alpha:1.0f]];
    
    
    [t setFont:[UIFont fontWithName:fontName size:fontSize]];
    [t setText:copy];
    [t sizeToFit];
    
    return t;
    
}

-(void)resizeToFitSubviews:(UIView *)thisView
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in [thisView subviews]) {
        float fw = v.frame.origin.x + v.frame.size.width;
        float fh = v.frame.origin.y + v.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [thisView setFrame:CGRectMake(thisView.frame.origin.x, thisView.frame.origin.y, w, h)];
}


@end

//
//  ToggleView.m
//  CoffeeSVP
//
//  Created by bmaci on 1/12/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "ToggleView.h"

@implementation ToggleView

@synthesize on;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.on)
        [[UIImage imageNamed:self.onImage] drawInRect:rect];
    else
        [[UIImage imageNamed:self.offImage] drawInRect:rect];
}

- (void)setOn:(BOOL)newOn
{
    on = newOn;
    
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

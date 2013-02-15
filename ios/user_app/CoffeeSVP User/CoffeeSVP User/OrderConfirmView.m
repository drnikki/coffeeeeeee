//
//  OrderConfirmView.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "OrderConfirmView.h"

@implementation OrderConfirmView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showView:(BOOL)visible
{
    [self setHidden:!visible];
    NSLog(@"OrderConfirmView:showView");
}

- (void)showView:(BOOL)visible withData:(OpenOrder *)data
{
    [self showView:visible];
    
    //set current date to show
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    
    //fill confirm view with data
    [[self itemDate] setText:[dateFormat stringFromDate:[data orderDate]]];
    [[self itemName] setText:[data orderItem]];
    [[self itemNotes] setText:[data orderNotes]];
    [[self itemPerson] setText:[data personId]];
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

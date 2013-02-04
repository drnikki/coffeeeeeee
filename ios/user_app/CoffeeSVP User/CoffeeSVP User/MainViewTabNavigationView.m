//
//  MainViewTabNavigationView.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "MainViewTabNavigationView.h"

@implementation MainViewTabNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initVerticalTabButtons
{
    self.orderButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0, verticalTabWidth, verticalTabHeight)];
    [self.orderButton setOnImage:@"btn_order_on.png"];
    [self.orderButton setOffImage:@"btn_order_off.png"];
    [self.orderButton setOn:YES];
    [self.orderButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.orderButton];
    
    self.statusButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight, verticalTabWidth, verticalTabHeight)];
    [self.statusButton setOnImage:@"btn_status_on.png"];
    [self.statusButton setOffImage:@"btn_status_off.png"];
    [self.statusButton setOn:NO];
    [self.statusButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.statusButton];
    
    self.historyButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*2, verticalTabWidth, verticalTabHeight)];
    [self.historyButton setOnImage:@"btn_history_on.png"];
    [self.historyButton setOffImage:@"btn_history_off.png"];
    [self.historyButton setOn:NO];
    [self.historyButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.historyButton];
    
    self.glossaryButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*3, verticalTabWidth, verticalTabHeight)];
    [self.glossaryButton setOnImage:@"btn_glossary_on.png"];
    [self.glossaryButton setOffImage:@"btn_glossary_off.png"];
    [self.glossaryButton setOn:NO];
    [self.glossaryButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.glossaryButton];
    
    self.galleryButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*4, verticalTabWidth, verticalTabHeight)];
    [self.galleryButton setOnImage:@"btn_gallery_on.png"];
    [self.galleryButton setOffImage:@"btn_gallery_off.png"];
    [self.galleryButton setOn:NO];
    [self.galleryButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.galleryButton];
    
    UITapGestureRecognizer *orderGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabOrderClick:)];
    UITapGestureRecognizer *statusGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabStatusClick:)];
    UITapGestureRecognizer *historyGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabHistoryClick:)];
    UITapGestureRecognizer *glossaryGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabGlossaryClick:)];
    UITapGestureRecognizer *galleryGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabGalleryClick:)];
    
    [self.orderButton addGestureRecognizer:orderGR];
    [self.statusButton addGestureRecognizer:statusGR];
    [self.historyButton addGestureRecognizer:historyGR];
    [self.glossaryButton addGestureRecognizer:glossaryGR];
    [self.galleryButton addGestureRecognizer:galleryGR];
}

- (void)tabOrderClick:(id)sender
{
    if( self.orderButton.on) return;
    
    [self.orderButton setOn:YES];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabNavClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: orderSlug, @"tabSlug", nil]];
}

- (void)tabStatusClick:(id)sender
{
    if( self.statusButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:YES];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabNavClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: statusSlug, @"tabSlug", nil]];
}

- (void)tabHistoryClick:(id)sender
{
    if( self.historyButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:YES];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabNavClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: historySlug, @"tabSlug", nil]];
}

- (void)tabGlossaryClick:(id)sender
{
    if( self.glossaryButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:YES];
    [self.galleryButton setOn:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabNavClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: glossarySlug, @"tabSlug", nil]];
}

- (void)tabGalleryClick:(id)sender
{
    if( self.galleryButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabNavClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: gallerySlug, @"tabSlug", nil]];
}



@end

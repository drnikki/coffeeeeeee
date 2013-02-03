//
//  MainViewController.m
//  CoffeeSVP User
//
//  Created by bmaci on 1/29/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initVerticalTabButtons];
    
    [self loadTabView:orderSlug];
    
    [self loadMenu];
}

- (void)initVerticalTabButtons
{
    self.orderButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0, verticalTabWidth, verticalTabHeight)];
    [self.orderButton setOnImage:@"btn_order_on.png"];
    [self.orderButton setOffImage:@"btn_order_off.png"];
    [self.orderButton setOn:YES];
    [self.orderButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.orderButton];
    
    self.statusButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight, verticalTabWidth, verticalTabHeight)];
    [self.statusButton setOnImage:@"btn_status_on.png"];
    [self.statusButton setOffImage:@"btn_status_off.png"];
    [self.statusButton setOn:NO];
    [self.statusButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.statusButton];
    
    self.historyButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*2, verticalTabWidth, verticalTabHeight)];
    [self.historyButton setOnImage:@"btn_history_on.png"];
    [self.historyButton setOffImage:@"btn_history_off.png"];
    [self.historyButton setOn:NO];
    [self.historyButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.historyButton];
    
    self.glossaryButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*3, verticalTabWidth, verticalTabHeight)];
    [self.glossaryButton setOnImage:@"btn_glossary_on.png"];
    [self.glossaryButton setOffImage:@"btn_glossary_off.png"];
    [self.glossaryButton setOn:NO];
    [self.glossaryButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.glossaryButton];
    
    self.galleryButton = [[ToggleView alloc] initWithFrame:CGRectMake(verticalTabX0, verticalTabY0 + verticalTabHeight*4, verticalTabWidth, verticalTabHeight)];
    [self.galleryButton setOnImage:@"btn_gallery_on.png"];
    [self.galleryButton setOffImage:@"btn_gallery_off.png"];
    [self.galleryButton setOn:NO];
    [self.galleryButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.galleryButton];
    
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

- (void)loadTabView:(NSString *)tabName
{
    
    //pop old
    for(UIView *subview in [self.tabsContainer subviews]) {
        [subview removeFromSuperview];
    }
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CGRect newSize = CGRectMake( 0.0f, 0.0f, 240.0f, 400.0f);
    
    if([tabName isEqualToString:orderSlug])
    {
        self.orderViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"orderView"];
        self.orderViewController.view.frame = newSize;
        self.orderViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabsContainer addSubview:self.orderViewController.view];
    }
    
    else if([tabName isEqualToString:statusSlug])
    {
        self.statusViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"statusView"];
        self.statusViewController.view.frame = newSize;
        self.statusViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabsContainer addSubview:self.statusViewController.view];
    }
    
    else if([tabName isEqualToString:historySlug])
    {
        
        self.historyViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"historyView"];
        self.historyViewController.view.frame = newSize;
        self.historyViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabsContainer addSubview:self.historyViewController.view];
        //[self.historyViewController setDelegate:self];
        
    }
    
    else if([tabName isEqualToString:glossarySlug])
    {
        self.glossaryViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"glossaryView"];
        self.glossaryViewController.view.frame = newSize;
        self.glossaryViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabsContainer addSubview:self.glossaryViewController.view];
    }
    
    else if([tabName isEqualToString:gallerySlug])
    {
        self.galleryViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"galleryView"];
        self.galleryViewController.view.frame = newSize;
        self.galleryViewController.view.backgroundColor = [UIColor clearColor];
        //[self.galleryViewController setDelegate:self];
        [self.tabsContainer addSubview:self.galleryViewController.view];
        
        
    }
    
}

- (void)loadMenu
{
    [ConnectionManager getMenuItems];
}

- (void)tabOrderClick:(id)sender
{
    if( self.orderButton.on) return;
    
    [self.orderButton setOn:YES];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [self loadTabView:orderSlug];
}

- (void)tabStatusClick:(id)sender
{
    if( self.statusButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:YES];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [self loadTabView:statusSlug];
}

- (void)tabHistoryClick:(id)sender
{
    if( self.historyButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:YES];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:NO];
    
    [self loadTabView:historySlug];
}

- (void)tabGlossaryClick:(id)sender
{
    if( self.glossaryButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:YES];
    [self.galleryButton setOn:NO];
    
    [self loadTabView:glossarySlug];
}

- (void)tabGalleryClick:(id)sender
{
    if( self.galleryButton.on) return;
    
    [self.orderButton setOn:NO];
    [self.statusButton setOn:NO];
    [self.historyButton setOn:NO];
    [self.glossaryButton setOn:NO];
    [self.galleryButton setOn:YES];
    
    [self loadTabView:gallerySlug];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    
    [self initObservers];
    [self initVerticalTabNav];
    [self initLoadingView];
    
    [self loadTabView:orderSlug];
    [self loadMenu];
}

- (void)initObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTabClicked:) name:@"TabNavClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMenuItemsLoaded:) name:@"MenuItemsLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMilkOptionsLoaded:) name:@"MilkOptionsLoaded" object:nil];
}

- (void)initVerticalTabNav
{
    [self.tabsNavView initVerticalTabButtons];
}

- (void)initLoadingView
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.loadingViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"loadingView"];
    
    [self.view addSubview:self.loadingViewController.view];
    
    self.loadingViewController.view.hidden = YES;
}

- (void)onTabClicked:(NSNotification *)notification
{
    [self loadTabView:[notification.userInfo objectForKey:@"tabSlug"]];
}

- (void)onMenuItemsLoaded:(NSNotification *)notification
{
    //now we load the milk options
    [ConnectionManager getMilkOptions];
}

- (void)onMilkOptionsLoaded:(NSNotification *)notification
{
    [self showLoadingView:NO];
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

- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label
{
    if(![label isEqualToString:@""]) [self.loadingViewController.loadingLabel setText:label];
    
    if(on)
    {
        //NSLog(@"SHOW ME SHOW ME SHOW ME!");
        self.loadingViewController.view.hidden = NO;
        self.loadingViewController.view.alpha = 1.0f;
    }
    
    else
    {
        //NSLog(@"HIDE ME HIDE ME HIDE ME");
        if (!self.loadingViewController.view.hidden)
            [UIView animateWithDuration:1.0 delay:0.0 options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.loadingViewController.view.alpha = 0.0;
                             }
                             completion:^(BOOL finished){
                                 self.loadingViewController.view.hidden = YES;
                             }];
    }
}

- (void)showLoadingView:(BOOL)on
{
    [self showLoadingView:on withLabel:@""];
}

- (void)loadMenu
{
    [self showLoadingView:YES withLabel:@"One moment please. Loading the menu..."];
    [ConnectionManager getMenuItems];
}

- (void) viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TabNavClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MenuItemsLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MilkOptionsLoaded" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

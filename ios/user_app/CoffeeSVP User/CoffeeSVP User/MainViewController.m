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
    
    self.prefs = [NSUserDefaults standardUserDefaults];
    
    [self initObservers];
    [self initVerticalTabNav];
    [self initLoadingView];
    [self initOpenOrderPrefs];
    
    [self loadTabView:orderSlug];
    [self loadMenu];
    
    NSLog(@"main view controller load");
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

- (void)initOpenOrderPrefs
{
    NSLog(@"MainViewController:initOpenOrderPrefs()");
    
    //check if we have drinks saved
    if(![self.prefs objectForKey:openOrders]) return;
    
    //check orderids in prefs
    NSMutableArray *orders = [self retrieveStoredOrders];
    
    NSLog(@"orders count: %i", [orders count]);
    
    //cleanse open orders of yesterday drinks
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *todayComps = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDateComponents *orderDayComps;// = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    
    /////// REMOVE /////////////
    //[todayComps setDay:-1];
    ////////////////////////////
    
    NSDate *today = [cal dateFromComponents:todayComps];
    NSDate *orderDay;
    
    int i;
   
    for( i = 0; i < [orders count]; i++)
    {
        orderDayComps = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[[orders objectAtIndex:i] orderDate]];
        orderDay = [cal dateFromComponents:orderDayComps];
        
        if(![today isEqualToDate:orderDay]) [orders removeObjectAtIndex:i];
    }
    
    [ConnectionManager shareInstance].openOrderDetails = orders;
    [self.prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:orders] forKey:openOrders];
    
    [ConnectionManager shareInstance].queueTotal = ([self.prefs integerForKey:currentQueueTotal]) ? [self.prefs integerForKey:currentQueueTotal] : 1;
}

- (NSMutableArray *)retrieveStoredOrders
{
    NSData *dataRepresentingSavedArray = [self.prefs objectForKey:openOrders];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            return [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            return [[NSMutableArray alloc] init];
    }
    
    else return [[NSMutableArray alloc] init];
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
        
        [self.orderViewController setDelegate:self];
    }
    
    else if([tabName isEqualToString:statusSlug])
    {
        self.statusViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"statusView"];
        self.statusViewController.view.frame = newSize;
        self.statusViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabsContainer addSubview:self.statusViewController.view];
        
        [self.statusViewController setDelegate:self];
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

- (void)loadTabView:(NSString *)tabName withNavUpdate:(BOOL)updateNav
{
    [self loadTabView:tabName];
    
    if(updateNav)
    {
        if([tabName isEqualToString:orderSlug]) [self.tabsNavView tabOrderClick:nil];
        else if([tabName isEqualToString:statusSlug]) [self.tabsNavView tabStatusClick:nil];
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

- (void) dealloc
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

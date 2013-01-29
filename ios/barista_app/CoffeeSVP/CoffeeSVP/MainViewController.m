//
//  MainViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/10/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "MainViewController.h"
#import "BaristaStatusViewController.h"
#import "Order.h"
#import "QueueViewController.h"
#import "SettingsViewController.h"
#import "StatsViewController.h"
#import "LoadingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize baristaStatusViewController = _baristaStatusViewController;
@synthesize queueViewController = _queueViewController;
@synthesize settingsViewController = _settingsViewController;
@synthesize statsViewController = _statsViewController;
@synthesize loadingViewController = _loadingViewController;
@synthesize specialInstructionsViewController = _specialInstructionsViewController;

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
    
    [self initStatusViewController];
    [self initVerticalTabButtons];
    [self initNotesView];
    [self initLoadingView];
}

- (void)initStatusViewController
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.baristaStatusViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"baristaStatusView"];
    CGRect newSize = CGRectMake( 0.0f, 0.0f, 768.0f, 50.0f);
    
    self.baristaStatusViewController.view.frame = newSize;
    self.baristaStatusViewController.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.baristaStatusViewController.view];
    
    [self.baristaStatusViewController setDelegate:self];
}

- (void)initVerticalTabButtons
{
    self.queueButton = [[ToggleView alloc] initWithFrame:CGRectMake(14, 85, 98, 91)];
    [self.queueButton setOnImage:@"btn_queue_on.png"];
    [self.queueButton setOffImage:@"btn_queue_off.png"];
    [self.queueButton setOn:NO];
    [self.queueButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.queueButton];
    
    self.settingsButton = [[ToggleView alloc] initWithFrame:CGRectMake(14, 176, 98, 91)];
    [self.settingsButton setOnImage:@"btn_settings_on.png"];
    [self.settingsButton setOffImage:@"btn_settings_off.png"];
    [self.settingsButton setOn:NO];
    [self.settingsButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.settingsButton];
    
    self.statsButton = [[ToggleView alloc] initWithFrame:CGRectMake(14, 267, 98, 91)];
    [self.statsButton setOnImage:@"btn_stats_on.png"];
    [self.statsButton setOffImage:@"btn_stats_off.png"];
    [self.statsButton setOn:YES];
    [self.statsButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.statsButton];
    
    UITapGestureRecognizer *queueGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabQueueClick:)];
    UITapGestureRecognizer *settingsGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSettingsClick:)];
    UITapGestureRecognizer *statsGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabStatsClick:)];
    
    [self.queueButton addGestureRecognizer:queueGR];
    [self.settingsButton addGestureRecognizer:settingsGR];
    [self.statsButton addGestureRecognizer:statsGR];
    
}

- (void)initNotesView
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.specialInstructionsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"specialInstructionsView"];
    
    [self.view addSubview:self.specialInstructionsViewController.view];
    
    self.specialInstructionsViewController.view.hidden = YES;
    
    UITapGestureRecognizer *notesGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNotesView:)];
    UITapGestureRecognizer *notesCloseGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNotesView:)];
    UITapGestureRecognizer *notesFlagGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flagDrink:)];
    
    [self.specialInstructionsViewController.view addGestureRecognizer:notesGR];
    [self.specialInstructionsViewController.closeButton addGestureRecognizer:notesCloseGR];
    [self.specialInstructionsViewController.flagDrinkButton addGestureRecognizer:notesFlagGR];
    
    // [self.notesView addGestureRecognizer:notesGR];
}

- (void)initLoadingView
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.loadingViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"loadingView"];
    
    [self.view addSubview:self.loadingViewController.view];
    
    self.loadingViewController.view.hidden = YES;
}

- (void) updateNotesView:(Order *)thisOrder
{
    self.specialInstructionsViewController.notesName.text = [thisOrder personID];
    self.specialInstructionsViewController.notesOrder.text = [thisOrder specialInstructions];
    self.specialInstructionsViewController.data = thisOrder;
    
    [self.specialInstructionsViewController.notesOrder sizeToFit];
    
    self.specialInstructionsViewController.view.hidden = NO;
    
    [UIView animateWithDuration:0.2 delay:0.0 options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.specialInstructionsViewController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //self.loadingView.hidden = YES;
                     }];
}

- (void) hideNotesView:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.specialInstructionsViewController.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.specialInstructionsViewController.view.hidden = YES;
                     }];
}

- (void) flagDrink:(NSNotification *)notification
{
    UIAlertView *orderUpdateAlert = [[UIAlertView alloc]
                                     initWithTitle:alertFlagTitle
                                     message:[NSString stringWithFormat:alertFlagBody, [self.specialInstructionsViewController.data personID]]
                                     delegate:self
                                     cancelButtonTitle:@"Yep!"
                                     otherButtonTitles:@"Not quite...", nil];
    [orderUpdateAlert show];
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


- (void)loadTabView:(NSString *)tabName
{
    
    //pop old
    for(UIView *subview in [self.tabContainer subviews]) {
        [subview removeFromSuperview];
    }
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CGRect newSize = CGRectMake( 0.0f, 0.0f, 646.0f, 854.0f);
    
    if([tabName isEqualToString:settingsSlug])
    {
        self.settingsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"settingsView"];
        self.settingsViewController.view.frame = newSize;
        self.settingsViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabContainer addSubview:self.settingsViewController.view];
    }
    
    else if([tabName isEqualToString:statsSlug])
    {
        self.statsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"statsView"];
        self.statsViewController.view.frame = newSize;
        self.statsViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabContainer addSubview:self.statsViewController.view];
    }
    
    else if([tabName isEqualToString:queueSlug])
    {
        
        if(![self.prefs boolForKey:@"queueViewLoaded"])
        {
            [self showLoadingView:YES withLabel:@"Loading drinks queue..."];
        }
        
        self.queueViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"queueView"];
        self.queueViewController.view.frame = newSize;
        self.queueViewController.view.backgroundColor = [UIColor clearColor];
        [self.tabContainer addSubview:self.queueViewController.view];
        [self.queueViewController setDelegate:self];
        
    }

}

- (void)tabQueueClick:(id)sender
{
    if( self.queueButton.on) return;
    
    [self.queueButton setOn:YES];
    [self.settingsButton setOn:NO];
    [self.statsButton setOn:NO];
    
    [self loadTabView:queueSlug];
}

- (void)tabSettingsClick:(id)sender
{
    if( self.settingsButton.on) return;
    
    [self.queueButton setOn:NO];
    [self.settingsButton setOn:YES];
    [self.statsButton setOn:NO];
    
    [self loadTabView:settingsSlug];
}

- (void)tabStatsClick:(id)sender
{
    if( self.statsButton.on) return;
    
    [self.queueButton setOn:NO];
    [self.settingsButton setOn:NO];
    [self.statsButton setOn:YES];
    
    [self loadTabView:statsSlug];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  BaristaStatusViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "BaristaStatusViewController.h"
#import "ConnectionManager.h"

@interface BaristaStatusViewController ()

@end

@implementation BaristaStatusViewController

@synthesize delegate;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusUpdated:) name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusLoaded:) name:@"StoreStatusLoaded" object:nil];
    
    [self initUI];
    [self activateUI];
}

- (void)openStore
{
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                            initWithTitle:alertTitle
                            message:alertOpen
                            delegate:self
                            cancelButtonTitle:@"Yes please!"
                            otherButtonTitles:@"No thanks!", nil];
    [statusChangeAlert show];
}

- (void)closeStore
{
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                            initWithTitle:alertTitle
                            message:alertClosed
                            delegate:self
                            cancelButtonTitle:@"Yes please!"
                            otherButtonTitles:@"No thanks!", nil];
    [statusChangeAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"alert view: %@", alertView.message);
    //NSLog(@"which button: %i", buttonIndex);
    
    if( [alertOpen isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusOpen];
            [self.delegate showLoadingView:YES withLabel:@"Powering the café up..."];
            NSLog(@"show loading view just got called in barista status view");
            //NSLog( @"OPEN SUCCESS");
            //[self openSuccess];
        }
    }
    
    else if( [alertClosed isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusClose];
            [self.delegate showLoadingView:YES withLabel:@"Powering the café down..."];
            //[self closedSuccess];
        }
    }
    
    else if( [alertBreak isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusBreak];
            //[self breakSuccess];
            self.alertHasShown = NO;
        }
        
        if(buttonIndex == 1)
        {
            [self onBreakSwitchRevert];
        }
    }
    
    else if( [alertBreakReturn isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusOpen];
            //[self breakSuccess];
            self.alertHasShown = NO;
        }
        
        if(buttonIndex == 1)
        {
            [self onBreakSwitchRevert];
        }
    }
}

- (void)openSuccess
{
    [self.powerButton setOn:YES];
    [self updateBreakSwitch:YES];
    
    [self.delegate showLoadingView:NO];
    
}

- (void)closedSuccess
{
    [self.powerButton setOn:NO];
    [self updateBreakSwitch:NO];
    
    [self.delegate showLoadingView:NO];
}

- (void)breakSuccess
{
    //self.alertHasShown = NO;
}

- (void)onBreakSwitchRevert
{
    if( self.onBreakSwitch.isOn ) [self.onBreakSwitch setOn:NO];
    else [self.onBreakSwitch setOn:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    //power button
    self.powerButton = [[ToggleView alloc] initWithFrame:CGRectMake(28, 17, 145, 40)];
    [self.powerButton setOnImage:@"power_down.png"];
    [self.powerButton setOffImage:@"power_up.png"];
    [self.powerButton setBackgroundColor:[UIColor clearColor]];
    [self.powerButton setOn:NO];
    
    [self.view addSubview:self.powerButton];
    
    //on break switch
    self.onBreakSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(574, 16, 177, 44)];
    [self.onBreakSwitch setOn:YES];
    [self.view addSubview:self.onBreakSwitch];
    
    //check for store on or off maybe?
    [self updateBreakSwitch:NO];
}

-(void)activateUI
{
    UITapGestureRecognizer *powerGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatePowerButton:)];
    
    [self.powerButton addGestureRecognizer:powerGR];
    
    [self.onBreakSwitch addTarget:self action:@selector(onSwitchUpdated:) forControlEvents:UIControlEventValueChanged];
}

-(void)onSwitchUpdated:(NSNotification *)notification
{
    if( self.alertHasShown )
    {
        self.alertHasShown = NO;
        return;
    }
    
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                                      initWithTitle:alertTitle
                                      message:alertBreak
                                      delegate:self
                                      cancelButtonTitle:@"Yes please!"
                                      otherButtonTitles:@"No thanks!", nil];
    if( self.onBreakSwitch.isOn )
    {
        [statusChangeAlert setMessage:alertBreakReturn];
    }
    
    [statusChangeAlert show];
    self.alertHasShown = YES;
}

-(void)updatePowerButton:(id)sender
{
    //Check the current state. Throw alert
    if( self.powerButton.on ) [self closeStore];
    else [self openStore];
    
    
    //[self.delegate showLoadingView:YES];
}

-(void)updateBreakSwitch:(BOOL)on
{
    [self.onBreakSwitch setEnabled:on];
    [self.onBreakSwitch setAlpha:( on ? 1.0f : 0.3f)];
    [self.onBreakSwitchLabel setAlpha:( on? 1.0f : 0.3f)];
}

-(void)onStatusUpdated:(NSNotification *)notification
{
    //NSLog(@"%@", [notification.userInfo objectForKey:@"value"]);
    
    if( [statusOpen isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self openSuccess];
    
    else if( [statusClose isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self closedSuccess];
    
    else if( [statusBreak isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self breakSuccess];
}

-(void)onStatusLoaded:(NSNotification *)notification
{
    [self.delegate showLoadingView:NO];
    
    if( [statusOpen isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self openSuccess];
    
    else if( [statusClose isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self closedSuccess];
    
    else if( [statusBreak isEqualToString:[ConnectionManager shareInstance].storeStatus]) [self breakSuccess];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StoreStatusLoaded" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StoreStatusLoaded" object:nil];
}

@end

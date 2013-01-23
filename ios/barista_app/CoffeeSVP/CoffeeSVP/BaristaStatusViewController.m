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
    
    [self initStates];
}

- (IBAction)openStore:(id)sender
{
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                            initWithTitle:alertTitle
                            message:alertOpen
                            delegate:self
                            cancelButtonTitle:@"Yes please!"
                            otherButtonTitles:@"No thanks!", nil];
    [statusChangeAlert show];
}

- (IBAction)closeStore:(id)sender
{
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                            initWithTitle:alertTitle
                            message:alertClosed
                            delegate:self
                            cancelButtonTitle:@"Yes please!"
                            otherButtonTitles:@"No thanks!", nil];
    [statusChangeAlert show];
}

- (IBAction)onBreakStore:(id)sender
{
    UIAlertView *statusChangeAlert = [[UIAlertView alloc]
                            initWithTitle:alertTitle
                            message:alertBreak
                            delegate:self
                            cancelButtonTitle:@"Yes please!"
                            otherButtonTitles:@"No thanks!", nil];
    [statusChangeAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert view: %@", alertView.message);
    NSLog(@"which button: %i", buttonIndex);
    
    if( [alertOpen isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusOpen];
            //NSLog( @"OPEN SUCCESS");
            //[self openSuccess];
        }
    }
    
    else if( [alertClosed isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusClose];
            //[self closedSuccess];
        }
    }
    
    else if( [alertBreak isEqualToString:alertView.message])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager updateStoreStatus:statusBreak];
            //[self breakSuccess];
        }
    }
}

- (void)openSuccess
{
    self.openButton.hidden = YES;
    self.openOn.hidden = NO;
    
    self.closedButton.hidden = self.onBreakButton.hidden = NO;
    self.closedOn.hidden = self.onBreakOn.hidden = YES;
}

- (void)closedSuccess
{
    self.closedButton.hidden = YES;
    self.closedOn.hidden = NO;
    
    self.openButton.hidden = self.onBreakButton.hidden = NO;
    self.openOn.hidden = self.onBreakOn.hidden = YES;
}

- (void)breakSuccess
{
    self.onBreakButton.hidden = YES;
    self.onBreakOn.hidden = NO;
    
    self.closedButton.hidden = self.openButton.hidden = NO;
    self.closedOn.hidden = self.openOn.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initStates
{
    self.openOn.hidden = self.onBreakOn.hidden = YES;
    self.closedButton.hidden = YES;
    
    self.openButton.hidden = self.onBreakButton.hidden = NO;
    self.closedOn.hidden = NO;
}

-(void)onStatusUpdated:(NSNotification *)notification
{
    NSLog(@"%@", [notification.userInfo objectForKey:@"value"]);
    
    if( [statusOpen isEqualToString:[notification.userInfo objectForKey:@"value"]]) [self openSuccess];
    
    else if( [statusClose isEqualToString:[notification.userInfo objectForKey:@"value"]]) [self closedSuccess];
    
    else if( [statusBreak isEqualToString:[notification.userInfo objectForKey:@"value"]]) [self breakSuccess];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
}

@end

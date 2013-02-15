//
//  OrderViewController.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitOrder:(BOOL)isSending
{
    if(isSending) [self.delegate showLoadingView:YES withLabel:@"Submitting your order..."];
    else [self.delegate showLoadingView:NO];
}

- (void)goToTab:(NSString *)slug
{
    [self.delegate loadTabView:slug withNavUpdate:YES];
}

@end

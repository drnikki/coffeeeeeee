//
//  IntroViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/9/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)enterClicked:(id)sender
{
    [UIView animateWithDuration:0.6 delay:0.0 options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.view.hidden = YES;
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

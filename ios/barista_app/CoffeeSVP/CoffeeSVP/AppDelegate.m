//
//  AppDelegate.m
//  CoffeeSVP
//
//  Created by bmaci on 1/9/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroViewController.h"
#import "BaristaStatusViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize introViewController = _introViewController;
@synthesize baristaStatusViewController = _baristaStatusViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //[self showIntroViewController];
    
    return YES;
}

- (void)showIntroViewController {
    NSLog(@"Show intro view");
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.introViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"introView"];
    [self.window addSubview:self.introViewController.view];
}

- (void)showStatusViewController {
    NSLog(@"Show status view");
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.baristaStatusViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"baristaStatusView"];
    CGRect newSize = CGRectMake( 0.0f, 200.0f, 768.0f, 50.0f);
    //BaristaStatusViewController *ssvc = [[StoreStatusViewController alloc] initWithNibName:@"StoreStatusViewController" bundle:nil];
    
    self.baristaStatusViewController.view.frame = newSize;
    self.baristaStatusViewController.view.backgroundColor = [UIColor clearColor];
    [self.window addSubview:self.baristaStatusViewController.view];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self showStatusViewController];
    [self showIntroViewController];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
//
//  AppUtilities.m
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "AppUtilities.h"
#import "ConnectionManager.h"

@implementation AppUtilities

+(void)slideOutTop:(UIView *)view
{
    CGRect temp = CGRectMake(0, -1024, view.frame.size.width, view.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = temp;
        
    } completion:^(BOOL finished) {
            [view removeFromSuperview];
    }];
    
}
/*

// Store Status Utilities
+ (BOOL)storeIsOpen
{
    return [[ConnectionManager shareInstance].storeStatus isEqualToString:statusOpen];
}

+ (BOOL)storeIsClosed
{
    return [[ConnectionManager shareInstance].storeStatus isEqualToString:statusClose];
}

+ (BOOL)storeIsOnBreak
{
    return [[ConnectionManager shareInstance].storeStatus isEqualToString:statusBreak];
}
 
 */

@end

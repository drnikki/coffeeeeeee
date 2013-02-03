//
//  AppUtilities.h
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

#define statusOpen @"open"
#define statusClose @"closed"
#define statusBreak @"on_break"

@interface AppUtilities : NSObject

+(void)slideOutTop:(UIView *)view;
/*
+ (BOOL)storeIsOpen;
+ (BOOL)storeIsClosed;
+ (BOOL)storeIsOnBreak;
*/
@end

//
//  AppUtilities.h
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

//store statuses
#define statusOpen @"open"
#define statusClose @"closed"
#define statusBreak @"on_break"

//tab slugs
#define orderSlug @"order"
#define statusSlug @"status"
#define historySlug @"history"
#define glossarySlug @"glossary"
#define gallerySlug @"gallery"

//keyboard offset
#define kOFFSET_FOR_KEYBOARD 80.0f


@interface AppUtilities : NSObject

+(void)slideOutTop:(UIView *)view;
/*
+ (BOOL)storeIsOpen;
+ (BOOL)storeIsClosed;
+ (BOOL)storeIsOnBreak;
*/
@end

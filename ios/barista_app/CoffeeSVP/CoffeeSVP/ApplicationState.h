//
//  ApplicationState.h
//  CoffeeSVP
//
//  Created by bmaci on 1/24/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationState : NSObject

// This is where I am to save all the data I need to keep the pages in their last state.

+ (ApplicationState *)shareInstance;

@end

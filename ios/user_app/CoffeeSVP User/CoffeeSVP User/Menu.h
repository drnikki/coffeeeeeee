//
//  Menu.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "MenuSpecial.h"

@interface Menu : NSObject

@property (nonatomic, strong) NSMutableArray *drinkItems;
@property (nonatomic, strong) NSMutableArray *milkOptions;
@property (nonatomic, strong) MenuSpecial *special;

@end

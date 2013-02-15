//
//  ConnectionManager.h
//  CoffeeSVP
//
//  Created by bmaci on 1/17/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "AppUtilities.h"
#import "MenuDrinkItem.h"
#import "OpenOrder.h"

#define dataServiceBase @"http://172.26.144.34:3002"

#define queueUrl @"queue"
#define ordersUrl @"orders"
#define menuUrl @"menu_items"
#define storeConfigsUrl @"store_configs"
#define milksUrl @"milks"
#define statusUrl @"status"

@interface ConnectionManager : NSObject

@property (strong, nonatomic) NSMutableArray *menuItems;
@property (strong, nonatomic) NSMutableArray *milkOptions;
@property (strong, nonatomic) NSMutableArray *openOrderDetails;
@property (nonatomic) int queueTotal;

+ (ConnectionManager *)shareInstance;

+ (void)getMenuItems;
+ (void)getMilkOptions;
+ (void)getStatuses;
+ (void)submitNewOrder:(NSString *)personId withItem:(NSString *)item andMilk:(NSString *)milk andSpecialInstructions:(NSString *)specialInstructions;

@end

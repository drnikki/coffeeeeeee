//
//  ConnectionManager.h
//  CoffeeSVP
//
//  Created by bmaci on 1/17/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

#define dataServiceBase @"http://172.26.144.34:3002"

#define queueUrl @"queue"
#define ordersUrl @"orders"
#define menuUrl @"menu_items"
#define storeConfigsUrl @"store_configs"
#define statusUrl @"status"

@interface ConnectionManager : NSObject

/*
@property (strong, nonatomic) NSMutableArray *orderQueue;
@property (strong, nonatomic) NSString *storeStatus;
@property BOOL queueHasLoaded;
@property BOOL isWritingToService;

+ (ConnectionManager *)shareInstance;

+ (void)getQueue;

+ (void)getStoreStatus;
+ (void)updateStoreStatus:(NSString *)withStatus;

+ (void)completeOrder:(NSString *)withID;
+ (void)flagOrder:(NSString *)withID;
*/

+ (void)getMenuItems;
+ (void)getMilkOptions;

@end

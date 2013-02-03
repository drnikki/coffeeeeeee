//
//  Order.h
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, strong) NSString *orderID;

@property (nonatomic, strong) NSString *personID;
@property (nonatomic, strong) NSString *orderItem;
@property (nonatomic, strong) NSString *specialInstructions;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *placedAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSDate *fulfilledAt;

@end

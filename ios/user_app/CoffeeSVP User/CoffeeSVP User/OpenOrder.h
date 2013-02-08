//
//  OpenOrder.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/6/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenOrder : NSObject

@property (nonatomic) int orderId;
@property (nonatomic, strong) NSString *personId;
@property (nonatomic, strong) NSString *orderItem;
@property (nonatomic, strong) NSString *orderNotes;
@property (nonatomic) int queuePlace;
@property (nonatomic) float waitTime;
@property (nonatomic, strong) NSDate *orderDate;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end

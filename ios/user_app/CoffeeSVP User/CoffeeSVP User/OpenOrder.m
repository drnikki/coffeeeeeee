//
//  OpenOrder.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/6/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "OpenOrder.h"

@implementation OpenOrder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.orderId forKey:@"orderId"];
    [coder encodeObject:self.personId forKey:@"personId"];
    [coder encodeObject:self.orderItem forKey:@"orderItem"];
    [coder encodeObject:self.orderNotes forKey:@"orderNotes"];
    [coder encodeInteger:self.queuePlace forKey:@"queuePlace"];
    [coder encodeFloat:self.waitTime forKey:@"waitTime"];
    [coder encodeObject:self.orderDate forKey:@"orderDate"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[OpenOrder alloc] init];
    if (self != nil)
    {
        self.orderId = [coder decodeIntegerForKey:@"orderId"];
        self.personId = [coder decodeObjectForKey:@"personId"];
        self.orderItem = [coder decodeObjectForKey:@"orderItem"];
        self.orderNotes = [coder decodeObjectForKey:@"orderNotes"];
        self.queuePlace = [coder decodeIntegerForKey:@"queuePlace"];
        self.waitTime = [coder decodeFloatForKey:@"waitTime"];
        self.orderDate = [coder decodeObjectForKey:@"orderDate"];
        
        
        
    }
    return self;
}

@end

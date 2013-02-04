//
//  MenuSpecial.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuSpecial : NSObject

@property (nonatomic, strong) NSString *specialId;
@property (nonatomic, strong) NSString *specialName;
@property (nonatomic, strong) NSString *specialDescription;
@property (nonatomic, strong) NSDate *validUntil;

@end

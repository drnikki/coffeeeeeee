//
//  GalleryPhoto.h
//  CoffeeSVP
//
//  Created by bmaci on 1/31/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryPhoto : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSString *profileUrl;

@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *comments;

@end

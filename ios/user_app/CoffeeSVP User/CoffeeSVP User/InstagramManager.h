//
//  InstagramManager.h
//  CoffeeSVP
//
//  Created by bmaci on 1/30/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

#define instagramBase @"https://api.instagram.com/v1"

//Photohopper clientID for testing only
#define clientID @"4a643d2d78d94daeae03aa53d6a479cf"

#define tagUrl @"tags"
#define recentUrl @"media/recent"

@interface InstagramManager : NSObject

@property (strong, nonatomic) NSMutableArray *taggedPhotos;
@property (strong, nonatomic) NSString *hashTag;

+ (InstagramManager *)shareInstance;

+ (void)getTaggedPhotos;

@end

//
//  InstagramManager.m
//  CoffeeSVP
//
//  Created by bmaci on 1/30/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "InstagramManager.h"
#import "GalleryPhoto.h"
#import "JSONKit.h"

@implementation InstagramManager

+ (InstagramManager *)shareInstance
{
    static InstagramManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[InstagramManager alloc] init];
            
            sharedSingleton.taggedPhotos = [[NSMutableArray alloc] init];
            sharedSingleton.hashTag = @"lbi_coffee";
        }
        return sharedSingleton;
    }
}

+ (void)getTaggedPhotos
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSString *urlAddress = [NSString stringWithFormat:@"%@/%@/%@/%@?client_id=%@", instagramBase, tagUrl, self.shareInstance.hashTag, recentUrl, clientID];
                       NSURL *url = [NSURL URLWithString:urlAddress];
                       NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                       NSURLResponse *response;
                       NSError *err;
                       NSData *jsonData = [NSURLConnection sendSynchronousRequest:requestObj returningResponse:&response error:&err];
                       JSONDecoder *decoder = [JSONDecoder decoderWithParseOptions:JKParseOptionStrict];
                       NSData *jsonList = [jsonData copy];
                       
                       NSMutableArray *photos = [[decoder objectWithData:jsonList] objectForKey:@"data"];
                       //NSLog(@"data: %@", jsonList);
                       //NSMutableArray *photos = [objectWithData:returnedData error:nil];
                       
                       NSLog(@"Photos: %@", photos);
                       
                       [[InstagramManager shareInstance].taggedPhotos removeAllObjects];
                       
                       int i;
                       
                       for( i = 0; i < [photos count]; i++ )
                       {
                           GalleryPhoto *p = [[GalleryPhoto alloc] init];
                           
                           [p setUsername:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"user.username"]];
                           [p setFullName:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"user.full_name"]];
                           [p setThumbUrl:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"images.thumbnail.url"]];
                           [p setDetailUrl:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"images.standard_resolution.url"]];
                           [p setProfileUrl:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"user.profile_picture"]];
                           [p setLikes:(NSString *)[[photos objectAtIndex:i] valueForKeyPath:@"likes.count"]];
                           [p setTags:(NSArray *)[[photos objectAtIndex:i] valueForKeyPath:@"tags"]];
                           
                           [[InstagramManager shareInstance].taggedPhotos addObject:p];
                           
                        }
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"TaggedPhotosLoaded" object:nil userInfo:nil];
                                      });
                   });
}

@end

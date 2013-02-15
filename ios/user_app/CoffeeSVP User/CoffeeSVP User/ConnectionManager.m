//
//  ConnectionManager.m
//  CoffeeSVP
//
//  Created by bmaci on 1/17/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager


+ (ConnectionManager *)shareInstance
{
    static ConnectionManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[ConnectionManager alloc] init];
            
            sharedSingleton.menuItems = [[NSMutableArray alloc] init];
            sharedSingleton.milkOptions = [[NSMutableArray alloc] init];
            sharedSingleton.openOrderDetails = [[NSMutableArray alloc] init];
            sharedSingleton.queueTotal = 0;
        }
        return sharedSingleton;
    }
}

+ (void)getMenuItems
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSString *urlAddress = [NSString stringWithFormat:@"%@/%@.json", dataServiceBase, menuUrl];
                       NSURL *url = [NSURL URLWithString:urlAddress];
                       NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                       NSURLResponse *response;
                       NSError *err;
                       NSData *jsonData = [NSURLConnection sendSynchronousRequest:requestObj returningResponse:&response error:&err];
                       JSONDecoder *decoder = [JSONDecoder decoderWithParseOptions:JKParseOptionStrict];
                       NSData *jsonList = [jsonData copy];
                       
                       
                       NSArray *menu = [decoder objectWithData:jsonList error:nil];
                       
                       [[ConnectionManager shareInstance].menuItems removeAllObjects];
                       
                       int i;
                       
                       for( i = 0; i < [menu count]; i++ )
                       {
                           MenuDrinkItem *o = [[MenuDrinkItem alloc] init];
                           
                           [o setDrinkId:(NSString *)[[menu objectAtIndex:i] objectForKey:@"id"]];
                           [o setDrinkName:(NSString *)[[menu objectAtIndex:i] objectForKey:@"name"]];
                           [o setDrinkDescription:(NSString *)[[menu objectAtIndex:i] objectForKey:@"description"]];
                           
                           [[ConnectionManager shareInstance].menuItems addObject:o];
                           
                       }
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"MenuItemsLoaded" object:nil userInfo:nil];
                                          
                                      });
                   });
}

+ (void)getMilkOptions
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSString *urlAddress = [NSString stringWithFormat:@"%@/%@/%@.json", dataServiceBase, storeConfigsUrl, milksUrl];
                       NSURL *url = [NSURL URLWithString:urlAddress];
                       NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                       NSURLResponse *response;
                       NSError *err;
                       NSData *jsonData = [NSURLConnection sendSynchronousRequest:requestObj returningResponse:&response error:&err];
                       JSONDecoder *decoder = [JSONDecoder decoderWithParseOptions:JKParseOptionStrict];
                       NSData *jsonList = [jsonData copy];
                       
                       
                       NSDictionary *milks = [decoder objectWithData:jsonList error:nil];
                       
                       [[ConnectionManager shareInstance].milkOptions removeAllObjects];
                       
                       NSString *milksString = [milks objectForKey:@"value"];
                       
                       NSLog(@"milks: %@", milksString);
                       
                       [ConnectionManager shareInstance].milkOptions = (NSMutableArray *)[milksString componentsSeparatedByString:@", "];
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"MilkOptionsLoaded" object:nil userInfo:nil];
                                          
                                      });
                   });
}

+ (void)getStatuses
{

}

+ (void)submitNewOrder:(NSString *)personId withItem:(NSString *)item andMilk:(NSString *)milk andSpecialInstructions:(NSString *)specialInstructions
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       
                       //get udid
                       NSString *uuidString = nil;
                       CFUUIDRef uuid = CFUUIDCreate(NULL);
                       if (uuid) {
                           uuidString = (__bridge NSString *)CFUUIDCreateString(NULL, uuid);
                           CFRelease(uuid);
                       }
                       NSLog(@"UDUD=====%@",uuidString);
                       
                       NSString *jsonRequest = [NSString stringWithFormat:@"{\"person_id\":\"%@\",\"item\":\"%@\",\"milk\":\"%@\",\"special_instructions\":\"%@\"}",personId, item, milk, specialInstructions];
                       //NSLog(@"Request: %@", jsonRequest);
                       
                       NSString *urlAddress = [NSString stringWithFormat:@"%@/%@.json", dataServiceBase, ordersUrl];
                       NSURL *url = [NSURL URLWithString:urlAddress];
                       
                       NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
                       NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
                       NSURLResponse *response;
                       NSError *err;
                       
                       [request setHTTPMethod:@"POST"];
                       [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                       [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                       [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
                       [request setHTTPBody: requestData];
                       
                       //NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
                       
                       NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                       JSONDecoder *decoder = [JSONDecoder decoderWithParseOptions:JKParseOptionStrict];
                       NSData *jsonList = [jsonData copy];
                       
                       NSDictionary *newOrderResponse = [decoder objectWithData:jsonList error:nil];
                       //NSString *oldStatus = [ConnectionManager shareInstance].storeStatus;
                       
                       NSLog(@"order added? %@", newOrderResponse);
                       //[ConnectionManager shareInstance].storeStatus =[newStatus objectForKey:@"value"];
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderSubmitted" object:nil userInfo:newOrderResponse];
                                      });
                   });
}

@end

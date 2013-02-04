//
//  UpcomingOrderCell.m
//  CoffeeSVP
//
//  Created by bmaci on 1/18/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "UpcomingOrderCell.h"
#import "ConnectionManager.h"

@implementation UpcomingOrderCell

@synthesize thisOrder, queuePosition;

- (void)awakeFromNib
{
}

- (void)prepareForReuse
{
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)drinkComplete:(id)sender
{
    //NSLog(@"Drink Complete");
    
    UIAlertView *orderUpdateAlert = [[UIAlertView alloc]
                                     initWithTitle:alertCompleteTitle
                                     message:[NSString stringWithFormat:alertCompleteBody, [thisOrder personID]]
                                     delegate:self
                                     cancelButtonTitle:@"Yep!"
                                     otherButtonTitles:@"Not quite...", nil];
    [orderUpdateAlert show];
    
    
    
    //[ConnectionManager completeOrder:[o orderID]];
}

- (IBAction)drinkFlag:(id)sender
{
    //NSLog(@"Drink Flag");
    
    UIAlertView *orderUpdateAlert = [[UIAlertView alloc]
                                     initWithTitle:alertFlagTitle
                                     message:[NSString stringWithFormat:alertFlagBody, [thisOrder personID]]
                                     delegate:self
                                     cancelButtonTitle:@"Yep!"
                                     otherButtonTitles:@"Not quite...", nil];
    [orderUpdateAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"alert view: %@", alertView.message);
    //NSLog(@"which button: %i", buttonIndex);
    
    if( [alertCompleteTitle isEqualToString:alertView.title])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager completeOrder:[thisOrder orderID]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CellOrderCompleted" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: self, @"row", nil]];
        }
    }
    
    else if( [alertFlagTitle isEqualToString:alertView.title])
    {
        if(buttonIndex == 0)
        {
            //[ConnectionManager updateStoreStatus:statusClose];
            //[self closedSuccess];
            
            NSLog(@"Drink Flagged");
        }
    }
}

- (IBAction)viewNote:(id)sender
{
    NSLog(@"View Note");
    //NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: thisOrder, @"order", nil];
    //NSLog(@"%@", dict);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CellNotesClicked" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: thisOrder, @"order", nil]];
}

@end

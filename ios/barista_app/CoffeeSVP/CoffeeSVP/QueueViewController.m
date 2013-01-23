//
//  QueueViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/12/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "QueueViewController.h"
#import "ConnectionManager.h"
#import "Order.h"
#import "UpcomingOrderCell.h"

@interface QueueViewController ()

@end

@implementation QueueViewController

@synthesize gaugeRotation, totalRotation, warningAlpha;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)gaugeDown:(id)sender
{
    if( totalRotation < -rotationLimit ) return;
    
    gaugeRotation = -0.2;
    totalRotation += gaugeRotation;
    
    warningAlpha = (totalRotation <= 0) ? 0 : (totalRotation / rotationLimit);
    
    [UIView animateWithDuration: 0.3f
                          delay: 0.0f
                        options: (UIViewAnimationOptionCurveEaseOut)
                     animations: ^{
                         self.dynamicNeedleView.transform = CGAffineTransformRotate(self.dynamicNeedleView.transform,gaugeRotation);
                     }
                     completion: ^(BOOL finished) {
                         //do nothing
                     }];
    
    [UIView animateWithDuration: 0.3f
                        delay: 0.0f
                        options: (UIViewAnimationOptionCurveEaseOut)
                        animations: ^{
                            self.dynamicNeedleBusy.alpha = warningAlpha;
                    }
                    completion: ^(BOOL finished) {
                        //do nothing
                    }];
}

- (IBAction)gaugeUp:(id)sender
{
    if( totalRotation > rotationLimit ) return;
    
    gaugeRotation = 0.2;
    totalRotation += gaugeRotation;
    
    warningAlpha = (totalRotation <= 0) ? 0 : (totalRotation / rotationLimit);

    [UIView animateWithDuration: 0.3f
                          delay: 0.0f
                        options: (UIViewAnimationOptionCurveEaseOut)
                     animations: ^{
                         self.dynamicNeedleView.transform = CGAffineTransformRotate(self.dynamicNeedleView.transform,gaugeRotation);
                     }
                     completion: ^(BOOL finished) {
                         //do nothing
                     }];
    
    [UIView animateWithDuration: 0.3f
                          delay: 0.0f
                        options: (UIViewAnimationOptionCurveEaseOut)
                     animations: ^{
                         self.dynamicNeedleBusy.alpha = warningAlpha;
                     }
                     completion: ^(BOOL finished) {
                         //do nothing
                     }];
}

- (void)initNeedle
{
    gaugeRotation = totalRotation = 0;
    warningAlpha = 0;
    
    self.dynamicNeedleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 252, 252)];
    
    self.dynamicNeedle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barista_gauge.png"]];
    self.dynamicNeedle.frame = CGRectMake( 0, 0, 252, 252);
    
    self.dynamicNeedleBusy = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barista_gauge_red.png"]];
    self.dynamicNeedleBusy.frame = CGRectMake( 0, 0, 252, 252);
    self.dynamicNeedleBusy.alpha = 0.0f;
    
    [self.needleView addSubview:self.dynamicNeedleView];
    
    [self.dynamicNeedleView addSubview:self.dynamicNeedle];
    [self.dynamicNeedleView addSubview:self.dynamicNeedleBusy];
}

- (void)initQueue
{
    [ConnectionManager getQueue];
}

- (IBAction)drinkComplete:(id)sender
{
    Order *o = [[ConnectionManager shareInstance].orderQueue objectAtIndex:0];
    
    UIAlertView *orderUpdateAlert = [[UIAlertView alloc]
                                      initWithTitle:alertCompleteTitle
                                      message:[NSString stringWithFormat:alertCompleteBody, [o personID]]
                                      delegate:self
                                      cancelButtonTitle:@"Yep!"
                                      otherButtonTitles:@"Not quite...", nil];
    [orderUpdateAlert show];
}

- (IBAction)drinkFlag:(id)sender
{
    Order *o = [[ConnectionManager shareInstance].orderQueue objectAtIndex:0];
    
    UIAlertView *orderUpdateAlert = [[UIAlertView alloc]
                                      initWithTitle:alertFlagTitle
                                      message:[NSString stringWithFormat:alertFlagBody, [o personID]]
                                      delegate:self
                                      cancelButtonTitle:@"Yep!"
                                      otherButtonTitles:@"Not quite...", nil];
    [orderUpdateAlert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Order *o = [[ConnectionManager shareInstance].orderQueue objectAtIndex:0];
    
    if( [alertCompleteTitle isEqualToString:alertView.title])
    {
        if(buttonIndex == 0)
        {
            [ConnectionManager completeOrder:[o orderID]];
        }
    }
    
    else if( [alertFlagTitle isEqualToString:alertView.title])
    {
        if(buttonIndex == 0)
        {
            //[ConnectionManager flagOrder:[o orderID]];
            NSLog(@"Drink Flagged");
        }
    }
}

- (void)rotateNeedle:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(degrees);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (IBAction)viewNote:(id)sender
{
    NSLog(@"View Note");
    
    [self updateNotesView:[[ConnectionManager shareInstance].orderQueue objectAtIndex:0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.upcomingOrderFeed setDelegate:self];
    [self.upcomingOrderFeed setDataSource:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrderQueueLoaded:) name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCellNotesLoaded:) name:@"CellNotesClicked" object:nil];
    
    [self initNeedle];
    [self initQueue];
    [self initNotesView];
}

-(void)onOrderQueueLoaded:(NSNotification *)notification
{
    //Order *o = [[ConnectionManager shareInstance].orderQueue objectAtIndex:0];
    //NSLog(@"Queue loaded: %@", [o orderItem]);
    
    // TURN LOADING OFF
    
    if (!self.loadingView.hidden)
        [UIView animateWithDuration:1.0 delay:0.0 options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.loadingView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             self.loadingView.hidden = YES;
                         }];
    
    [self updateCurrentOrder];
    [self.upcomingOrderFeed reloadData];
    
}

-(void)onCellNotesLoaded:(NSNotification *)notification
{
    [self updateNotesView:[notification.userInfo objectForKey:@"order"]];
}

- (void) updateCurrentOrder
{
    //check for empty array
    if([[ConnectionManager shareInstance].orderQueue count] == 0)
    {
        self.queueEmptyView.hidden = NO;
        self.currentOrderView.hidden = YES;
        return;
    }
    
    self.queueEmptyView.hidden = YES;
    self.currentOrderView.hidden = NO;
    
    Order *current = [[ConnectionManager shareInstance].orderQueue objectAtIndex:0];
    
    if([current personID] != (NSString *)[NSNull null]) [self currentName].text = [current personID];
    else [self currentName].text = @"No Name";
        
    [self currentOrder].text = [current orderItem];
    
    if([current specialInstructions] == (NSString *)[NSNull null] || [[current specialInstructions] isEqualToString:@""] ) [self notesButton].hidden = YES;
}

//Table View functions
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int orderCount = [[ConnectionManager shareInstance].orderQueue count];
    return orderCount - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UpcomingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"upcomingOrderItem"];
    
    if(cell == nil )
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"upcomingOrderItem" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UpcomingOrderCell class]])
            {
                cell = (UpcomingOrderCell *)currentObject;
                break;
            }
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    Order *o = [[ConnectionManager shareInstance].orderQueue objectAtIndex:indexPath.row+1];
    
    
    if([o personID] != (NSString *)[NSNull null]) cell.nameLabel.text = [o personID];
    else cell.nameLabel.text = @"No Name";
    
    if([o orderItem] != (NSString *)[NSNull null]) cell.itemLabel.text = [o orderItem];
    else cell.itemLabel.text = @"Invalid Order";
    
    if([o specialInstructions] == (NSString *)[NSNull null] || [[o specialInstructions] isEqualToString:@""]) cell.notesButton.hidden = YES;
    
    [cell setThisOrder:o];
    
    return cell;
}

// Notes View Methods //

- (void) initNotesView
{
    self.notesView.hidden = YES;
    self.notesView.alpha = 0.0f;
    
    UITapGestureRecognizer *notesGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNotesView:)];
    
    [self.notesView addGestureRecognizer:notesGR];
}

- (void) updateNotesView:(Order *)thisOrder
{
    self.notesName.text = [thisOrder personID];
    self.notesOrder.text = [thisOrder specialInstructions];
    
    self.notesView.hidden = NO;
    //self.notesView.alpha = 1.0f;
    
    [UIView animateWithDuration:0.2 delay:0.0 options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.notesView.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //self.loadingView.hidden = YES;
                     }];
}

- (void) hideNotesView:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.notesView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.notesView.hidden = YES;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellNotesClicked" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellNotesClicked" object:nil];
}

@end

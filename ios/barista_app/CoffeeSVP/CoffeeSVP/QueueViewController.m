//
//  QueueViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/12/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "QueueViewController.h"
#import "AppUtilities.h"
#import "ConnectionManager.h"
#import "Order.h"
#import "UpcomingOrderCell.h"

@interface QueueViewController ()

@end

@implementation QueueViewController

@synthesize gaugeRotation, totalRotation, warningAlpha;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.prefs = [NSUserDefaults standardUserDefaults];
    
    [self.upcomingOrderFeed setDelegate:self];
    [self.upcomingOrderFeed setDataSource:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrderQueueLoaded:) name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCellNotesLoaded:) name:@"CellNotesClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCellOrderCompleted:) name:@"CellOrderCompleted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCellOrderFlagged:) name:@"CellOrderFlagged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusUpdated:) name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusLoaded:) name:@"StatusLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusFirstOpened:) name:@"StatusFirstOpened" object:nil];
    
    [self initNeedle];
    [self initDynamicGaugeValues];
    [self initQueueElements];
    [self initSoundEffects];
    
    if (!self.loopTimer)
    {
        if(![self.prefs boolForKey:@"queueViewLoaded"])
        {
            [self loadQueue];
            //[self.delegate showLoadingView:YES];
        }
        else [self updateQueue];
        
        self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(loadQueue) userInfo: nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.loopTimer forMode:NSRunLoopCommonModes];
    }
    
    if(![self.prefs boolForKey:@"queueViewLoaded"])
    {
        NSLog(@"NO VALUE!");
        [self.prefs setBool:YES forKey:@"queueViewLoaded"];
        
    }
    
    else [self setStage];
    
    
    NSLog(@"View Did Load");
    
}

- (void)initQueueElements
{
    //hide everything until we know the store status
    [self.currentOrderView setHidden:YES];
    //[self.upcomingOrderFeed setHidden:YES];
    [self.queueEmptyView setHidden:YES];
    [self.mustOpenView setHidden:YES];
}

- (void)initSoundEffects
{
    self.soundEffect = [[SoundEffect alloc] init];
}

- (void)setStage
{
    
    totalRotation = [self.prefs floatForKey:@"needleRotation"];
    warningAlpha = [self.prefs floatForKey:@"needleAlpha"];
    
    //NSLog(@"prefs: %f", totalRotation);
    
    self.dynamicNeedleView.transform = CGAffineTransformRotate(self.dynamicNeedleView.transform,totalRotation);
    self.dynamicNeedleBusy.alpha = warningAlpha;
}

- (void)initNeedle
{
    
    gaugeRotation = totalRotation = 0;
    warningAlpha = 0;
    
    //[self.prefs setFloat:totalRotation forKey:@"needleRotation"];
    //[self.prefs setFloat:warningAlpha forKey:@"needleAlpha"];
    
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

- (void)initDynamicGaugeValues
{
    float color = (41/255);
    
    //add five rotated labels to dynamicValuesView
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(190, 40, 24, 24)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(242, -6, 24, 24)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(310, -24, 24, 24)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(378, -6, 24, 24)];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(430, 40, 24, 24)];
    
    label0.numberOfLines = label1.numberOfLines = label2.numberOfLines = label3.numberOfLines = label4.numberOfLines = 1;
    label0.backgroundColor = label1.backgroundColor = label2.backgroundColor = label3.backgroundColor = label4.backgroundColor = [UIColor clearColor];
    
    [label0 setTextAlignment:NSTextAlignmentCenter];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [label3 setTextAlignment:NSTextAlignmentCenter];
    [label4 setTextAlignment:NSTextAlignmentCenter];
    
    [label0 setTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
    [label1 setTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
    [label2 setTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
    [label3 setTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
    [label4 setTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
    
    [label0 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [label1 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [label2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [label3 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [label4 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    
    label0.text = @"2";
    label1.text = @"4";
    label2.text = @"6";
    label3.text = @"8";
    label4.text = @"10";
    
    [label0 setTransform:CGAffineTransformMakeRotation( -M_PI/3 )];
    [label1 setTransform:CGAffineTransformMakeRotation( -M_PI/6 )];
    [label3 setTransform:CGAffineTransformMakeRotation( M_PI/6 )];
    [label4 setTransform:CGAffineTransformMakeRotation( M_PI/3 )];
    
    [self.dynamicValuesView addSubview:label0];
    [self.dynamicValuesView addSubview:label1];
    [self.dynamicValuesView addSubview:label2];
    [self.dynamicValuesView addSubview:label3];
    [self.dynamicValuesView addSubview:label4];
}

- (void)loadQueue
{
    [ConnectionManager getQueue];
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
    
    [self.prefs setFloat:totalRotation forKey:@"needleRotation"];
    [self.prefs setFloat:warningAlpha forKey:@"needleAlpha"];
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
    
    [self.prefs setFloat:totalRotation forKey:@"needleRotation"];
    [self.prefs setFloat:warningAlpha forKey:@"needleAlpha"];
    
    //NSLog(@"totalRotation: %f", [self.prefs floatForKey:@"needleRotation"]);
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
            [[ConnectionManager shareInstance].orderQueue removeObjectAtIndex:0];
            
            [self updateQueue];
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
    [self.delegate updateNotesView:[[ConnectionManager shareInstance].orderQueue objectAtIndex:0]];
}

-(void)onOrderQueueLoaded:(NSNotification *)notification
{
    [self.delegate showLoadingView:NO];
    
    if( ![ConnectionManager shareInstance].isWritingToService )[self updateQueue];
    
    [self.loopTimer invalidate];
    self.loopTimer = nil;
    self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(loadQueue) userInfo: nil repeats:NO];
    
}

- (void)onStatusLoaded:(NSNotification *)notification
{
    if( [AppUtilities storeIsClosed] )
    {
        [self.currentOrderView setHidden:YES];
        //[self.upcomingOrderFeed setHidden:YES];
        [self.queueEmptyView setHidden:YES];
        [self.mustOpenView setHidden:NO];
    }
    
    else if( [AppUtilities storeIsOpen] )
    {
        [self.mustOpenView setHidden:YES];
        [self loadQueue];
    }
}

- (void)onStatusUpdated:(NSNotification *)notification
{
    if( [AppUtilities storeIsOpen] )
    {
        [self.mustOpenView setHidden:YES];
        [self updateQueue];
    }
    
    else if( [AppUtilities storeIsClosed] )
    {
        [self.currentOrderView setHidden:YES];
        //[self.upcomingOrderFeed setHidden:YES];
        [self.queueEmptyView setHidden:YES];
        [self.mustOpenView setHidden:NO];
        
        [self.loopTimer invalidate];
        self.loopTimer = nil;
        //gut queue?
    }
}

-(void)onStatusFirstOpened:(NSNotification *)notification
{
    [self.currentOrderView setHidden:YES];
    //[self.upcomingOrderFeed setHidden:NO];
    [self.queueEmptyView setHidden:YES];
    [self.mustOpenView setHidden:YES];
    
    [self loadQueue];
}

-(void)updateQueue
{
    [self updateCurrentOrder];
    [self.upcomingOrderFeed reloadData];
    [self updateQueueTotal];
}

-(void)onCellNotesLoaded:(NSNotification *)notification
{
    [self.delegate updateNotesView:[notification.userInfo objectForKey:@"order"]];
}

-(void)onCellOrderCompleted:(NSNotification *)notification
{
    [[ConnectionManager shareInstance].orderQueue removeObjectAtIndex:[(UpcomingOrderCell *)[notification.userInfo objectForKey:@"row"] queuePosition]];
    [self updateQueue];
}

-(void)onCellOrderFlagged:(NSNotification *)notification
{
    [self.delegate updateNotesView:[notification.userInfo objectForKey:@"order"]];
    
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
        
    [self currentOrder].text = [NSString stringWithFormat:@"%@ %@", [current milkOption], [current orderItem]];
    
    if([current priority] == (NSString *)[NSNull null]) self.currentPriority.hidden = YES;
    else self.currentPriority.hidden = NO;
    
    if([current specialInstructions] == (NSString *)[NSNull null] || [[current specialInstructions] isEqualToString:@""] ) [self notesButton].hidden = YES;
    else [self notesButton].hidden = NO;
}

-(void) updateQueueTotal
{
    //ding if we have new ones
    int oldCount = [self.queueTotal.text intValue];
    if([[ConnectionManager shareInstance].orderQueue count] >= 10) [self.queueTotal setText:[NSString stringWithFormat:@"%u", [[ConnectionManager shareInstance].orderQueue count]]];
    else [self.queueTotal setText:[NSString stringWithFormat:@"0%u", [[ConnectionManager shareInstance].orderQueue count]]];
    
    if([self.queueTotal.text intValue] > oldCount) [self.soundEffect newOrderSound];
    
    //NSLog(@"old: %i, new: %i", oldCount, (int)self.queueTotal.text);
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
    
    if([o orderItem] != (NSString *)[NSNull null]) cell.itemLabel.text = [NSString stringWithFormat:@"%@ %@", [o milkOption], [o orderItem]];
    else cell.itemLabel.text = @"Invalid Order";
    
    if([o specialInstructions] == (NSString *)[NSNull null] || [[o specialInstructions] isEqualToString:@""]) cell.notesButton.hidden = YES;
    else cell.notesButton.hidden = NO;
    
    if([o priority] == (NSString *)[NSNull null]) cell.priority.hidden = YES;
    else cell.priority.hidden = NO;
    [cell setThisOrder:o];
    [cell setQueuePosition:indexPath.row+1];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillUnload
{
    [super viewWillUnload];
    
    //NSLog(@"total rotation:%f", self.totalRotation);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.loopTimer)
    {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    NSLog(@"View Did Unload");
    
    if (self.loopTimer)
    {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellNotesClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderCompleted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderFlagged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusFirstOpened" object:nil];
}

- (void)dealloc
{
    if (self.loopTimer)
    {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellNotesClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderCompleted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderFlagged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusFirstOpened" object:nil];
}

@end

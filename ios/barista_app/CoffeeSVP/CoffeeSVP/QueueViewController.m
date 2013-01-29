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
    
    [self initNeedle];
    //[self initNotesView];
    
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
    //[self loadQueue];
    
    if(![self.prefs boolForKey:@"queueViewLoaded"])
    {
        NSLog(@"NO VALUE!");
        [self.prefs setBool:YES forKey:@"queueViewLoaded"];
        
    }
    
    else
    {
        [self setStage];
    }
    
    NSLog(@"View Did Load");
    
}

- (void)setStage
{
    
    totalRotation = [self.prefs floatForKey:@"needleRotation"];
    warningAlpha = [self.prefs floatForKey:@"needleAlpha"];
    
    NSLog(@"prefs: %f", totalRotation);
    
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
    NSLog(@"View Note");
    
    [self.delegate updateNotesView:[[ConnectionManager shareInstance].orderQueue objectAtIndex:0]];
}

-(void)onOrderQueueLoaded:(NSNotification *)notification
{
    /*
    if (!self.loadingView.hidden)
        [UIView animateWithDuration:1.0 delay:0.0 options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.loadingView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             self.loadingView.hidden = YES;
                         }];
    */
    //[self.parentViewController showLoadingView:NO];
    
    
    [self.delegate showLoadingView:NO];
    
    [self updateQueue];
    
    [self.loopTimer invalidate];
    self.loopTimer = nil;
    self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(loadQueue) userInfo: nil repeats:NO];
    
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
        
    [self currentOrder].text = [current orderItem];
    
    if([current specialInstructions] == (NSString *)[NSNull null] || [[current specialInstructions] isEqualToString:@""] ) [self notesButton].hidden = YES;
    else [self notesButton].hidden = NO;
}

-(void) updateQueueTotal
{
    
    if([[ConnectionManager shareInstance].orderQueue count] >= 10) [self.queueTotal setText:[NSString stringWithFormat:@"%u", [[ConnectionManager shareInstance].orderQueue count]]];
    else [self.queueTotal setText:[NSString stringWithFormat:@"0%u", [[ConnectionManager shareInstance].orderQueue count]]];
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
    else cell.notesButton.hidden = NO;
    
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderQueueLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellNotesClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderCompleted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CellOrderFlagged" object:nil];
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
}

@end

//
//  StatusViewController.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/2/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "StatusViewController.h"

@interface StatusViewController ()

@end

@implementation StatusViewController

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
    [self.statusFeed setDelegate:self];
    [self.statusFeed setDataSource:self];
    
    self.prefs = [NSUserDefaults standardUserDefaults];
    /*
    if (!self.loopTimer)
    {
        if(![self.prefs boolForKey:@"statusViewLoaded"])
        {
            [self loadStatuses];
        }
        else [self updateStatuses];
        
        self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(loadStatuses) userInfo: nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.loopTimer forMode:NSRunLoopCommonModes];
    }
    */
    [self.emptyStatusView setHidden:YES];
    [self initStatusLoading];
    
    //else [self setStage];

}

- (void)initStatusLoading
{
    //is there data in the ConnectionManager?
    if( [[ConnectionManager shareInstance].openOrderDetails count])
    {
        //if yes
        [self updateStatuses];
        
        //then load statuses which will start the loop
        [self loadStatuses];
    }
    
    else
    {
        //if no
        //is there data in prefs?
        //if([self.prefs arrayForKey:openOrders])
        //{
            //if yes
        //    [self.delegate showLoadingView:YES withLabel:@"One moment. Updating order status..."];
            
        //    [self loadStatuses];
        //}
        
        //else
        //{
            //if no
            //show the empty status view
            [self.emptyStatusView setHidden:NO];
        //}
    }
}

- (void)loadStatuses
{
    //load from CM. When complete, start the loop.
    //NSLog(@"here are the ids: %@", self.currentLoadArray);
}

- (void)updateStatuses
{
    [self.statusFeed reloadData];
}

//Table View functions
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int orderCount = [[ConnectionManager shareInstance].openOrderDetails count];
    return orderCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StatusOpenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusOpenOrderItem"];
    
    if(cell == nil )
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"statusOpenOrderItem" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[StatusOpenOrderCell class]])
            {
                cell = (StatusOpenOrderCell *)currentObject;
                break;
            }
        }
    }
    
    [cell setData:[[ConnectionManager shareInstance].openOrderDetails objectAtIndex:indexPath.row]];
    
    return cell;
}

-(IBAction)goToOrder:(id)sender
{
    [self.delegate loadTabView:orderSlug withNavUpdate:YES];
}

-(void) viewDidUnload
{
    if (self.loopTimer)
    {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}

-(void) dealloc
{
    if (self.loopTimer)
    {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

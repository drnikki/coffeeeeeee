//
//  GalleryViewController.m
//  CoffeeSVP
//
//  Created by bmaci on 1/30/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryPhoto.h"
#import "GalleryPhotoView.h"
#import "InstagramManager.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadThumbs:) name:@"TaggedPhotosLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDetail:) name:@"ImageTapped" object:nil];
    
    [self loadGallery];
    
    [self.photoDetail setHidden:YES];
}

- (void)loadGallery
{
    //[self.delegate showLoadingView:YES withLabel:@"Loading gallery data..."];
    [InstagramManager getTaggedPhotos];
    
}

-(void)loadThumbs:(NSNotification *)notification
{
    [self.delegate showLoadingView:NO];
    
    int i;
    
    for(i = 0; i < [[InstagramManager shareInstance].taggedPhotos count]; i++)
    {
        GalleryPhoto *p = [[InstagramManager shareInstance].taggedPhotos objectAtIndex:i];
        
        GalleryPhotoView *thumb = [[GalleryPhotoView alloc] initWithFrame:CGRectMake((i % rowCount)*photoWidth, floor(i/rowCount)*photoWidth, photoWidth, photoWidth)];
        [thumb populatePhoto:p];
        [thumb loadPhoto];
        
        [self.photoScroll addSubview:thumb];
        
        
    }
    
    [self.photoScroll setNeedsDisplay];
    [self.photoScroll setContentSize:CGSizeMake(640, ceil([[InstagramManager shareInstance].taggedPhotos count] / rowCount)*photoWidth)];
}

-(void)loadDetail:(NSNotification *)notification
{
    [self.photoDetail updateView:[notification.userInfo objectForKey:@"imgData"]];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TaggedPhotosLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ImageTapped" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

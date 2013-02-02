//
//  GalleryViewController.h
//  CoffeeSVP
//
//  Created by bmaci on 1/30/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryPhotoDetailView.h"

#define photoWidth 160.0f
#define rowCount 4

@protocol GalleryViewControllerDelegate <NSObject>
- (void)showLoadingView:(BOOL)on;
- (void)showLoadingView:(BOOL)on withLabel:(NSString *)label;
@end

@interface GalleryViewController : UIViewController

@property (assign) id <GalleryViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIScrollView *photoScroll;
@property (nonatomic, strong) IBOutlet GalleryPhotoDetailView *photoDetail;

@end

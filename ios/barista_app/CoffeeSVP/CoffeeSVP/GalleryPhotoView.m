//
//  GalleryPhotoView.m
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "GalleryPhotoView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation GalleryPhotoView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //load default image
    }
    return self;
}

- (void) populatePhoto:(GalleryPhoto *)withData
{
    [self setData:withData];
}

- (void) loadPhoto
{
    
    self.thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 160.0f, 160.0f)];
    [self.thumbImage setImageWithURL:[NSURL URLWithString:[self.data thumbUrl]] placeholderImage:[UIImage imageNamed:@"gallery_image_default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [self.thumbImage setAlpha:0.0f];
        
        [UIView animateWithDuration:0.6 delay:0.0 options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.thumbImage.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             //self.loadingView.hidden = YES;
                         }];
        
    }];
    [self addSubview:self.thumbImage];
    [self initGesture];
    
}

- (void)initGesture
{
    UITapGestureRecognizer *thumbGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbTap:)];
    [self addGestureRecognizer:thumbGR];
}

- (void)thumbTap:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageTapped" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: self.data, @"imgData", nil]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  GalleryPhotoView.h
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryPhoto.h"

#define defaultImageName @"gallery_image_default.png"

@interface GalleryPhotoView : UIView

@property (nonatomic, strong) UIImageView *thumbImage;

@property (nonatomic, strong) GalleryPhoto *data;

- (void) populatePhoto:(GalleryPhoto *)withData;
- (void) loadPhoto;

@end

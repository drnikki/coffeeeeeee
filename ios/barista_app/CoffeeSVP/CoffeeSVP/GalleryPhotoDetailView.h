//
//  GalleryPhotoDetailView.h
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryPhoto.h"

#define tagTotalWidth 552
#define tagRowHeight 26
#define spaceSize 8

@interface GalleryPhotoDetailView : UIView

@property (nonatomic, strong) IBOutlet UILabel *userName;
@property (nonatomic, strong) IBOutlet UILabel *fullName;
@property (nonatomic, strong) IBOutlet UILabel *likeCount;
@property (nonatomic, strong) IBOutlet UIImageView *profileImage;
@property (nonatomic, strong) IBOutlet UIImageView *detailImage;
@property (nonatomic, strong) IBOutlet UIScrollView *tagsView;

-(void)updateView:(GalleryPhoto *)data;

@end

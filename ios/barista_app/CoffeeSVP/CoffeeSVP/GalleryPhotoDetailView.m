//
//  GalleryPhotoDetailView.m
//  CoffeeSVP
//
//  Created by bmaci on 2/1/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "GalleryPhotoDetailView.h"
#import "GalleryPhoto.h"
#import "InstagramManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation GalleryPhotoDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)updateView:(GalleryPhoto *)data
{
    [self setHidden:NO];
    
    [self.userName setText:[data username]];
    [self.fullName setText:[data fullName]];
    [self.likeCount setText:[NSString stringWithFormat:@"%@ likes", [data likes]]];
    
    [self loadProfilePhoto:[data profileUrl]];
    [self loadDetailPhoto:[data detailUrl]];
    
    [self loadTags:[data tags]];
    
}

-(void) loadProfilePhoto:(NSString *)url
{
    [self.profileImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    [self.profileImage setAlpha:0.0f];
            
    [UIView animateWithDuration:0.6 delay:0.0 options: UIViewAnimationCurveEaseOut
                    animations:^{
                        self.profileImage.alpha = 1.0f;
                    }
                     completion:nil
            
        ];
    }];
}

-(void) loadDetailPhoto:(NSString *)url
{
    [self.detailImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [self.detailImage setAlpha:0.0f];
        
        [UIView animateWithDuration:0.6 delay:0.0 options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.detailImage.alpha = 1.0f;
                         }
                         completion:nil
         
         ];
    }];
}

- (void)loadTags:(NSArray *)tags
{
    int i;
    int rowIndex;
    float rowWidth;
    UILabel *last;
    
    rowIndex = 0;
    rowWidth = 0;
    
    //gut tagsView
    for(UIView *subview in [self.tagsView subviews]) {
        [subview removeFromSuperview];
    }
    
    for( i = 0; i < [tags count]; i++)
    {
        if( last != nil)
        {
            rowWidth += last.frame.size.width + spaceSize;
            
            //check if adding last bumped the width over the top
            if(rowWidth > tagTotalWidth)
            {
                //move it
                rowWidth = 0;
                rowIndex++;
                
                CGRect f = CGRectMake( rowWidth, (rowIndex * tagRowHeight), last.frame.size.width, last.frame.size.height);
                
                [last setFrame:f];
                rowWidth += last.frame.size.width + spaceSize;
            }
        }
        
        last = [self addNewTagLabel:[tags objectAtIndex:i] atX:rowWidth atY:(rowIndex * tagRowHeight)];
    }
    
    [self.tagsView setContentSize:CGSizeMake(552, rowIndex * tagRowHeight)];
}

- (UILabel *)addNewTagLabel:(NSString *)copy atX:(float)x atY:(float)y
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 45, 45)];
    
    [t setNumberOfLines:1];
    [t setBackgroundColor:[UIColor clearColor]];
    [t setTextAlignment:NSTextAlignmentLeft];
    
    if(![copy isEqualToString:[InstagramManager shareInstance].hashTag] )
    {
        [t setTextColor:[UIColor whiteColor]];
    }
    
    else
    {
        [t setTextColor:[UIColor colorWithRed:(168/255.0f) green:(139/255.0f) blue:(22/255.0f) alpha:1.0f]];
    }
    
    [t setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25.0f]];
    [t setText:[NSString stringWithFormat:@"#%@",copy]];
    [t sizeToFit];
    
    [self.tagsView addSubview:t];
    
    return t;
    
}

-(IBAction) closeDetail:(id)sender
{
    [self setHidden:YES];
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

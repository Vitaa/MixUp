//
//  GameView.m
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Al Digit. All rights reserved.
//

#import "GameView.h"

@interface GameView ()
@property (nonatomic, retain) NSArray * imageNames;

- (void)fillScrollView:(UIScrollView*)scrollView fromFolder:(NSString*)folder;
@end

@implementation GameView

@synthesize imageNames;

- (id)initWithImageNames:(NSArray*)imageNames_
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.imageNames = imageNames_;
        
        headsScrollView = [[[UIScrollView alloc] initWithFrame:CGRectZero] autorelease];
        headsScrollView.pagingEnabled = YES;
        [self addSubview:headsScrollView];
        [self fillScrollView:headsScrollView fromFolder:@"heads"];
        
        bodiesScrollView = [[[UIScrollView alloc] initWithFrame:CGRectZero] autorelease];
        bodiesScrollView.pagingEnabled = YES;
        [self addSubview:bodiesScrollView];
        [self fillScrollView:bodiesScrollView fromFolder:@"bodies"];
        
        feetScrollView = [[[UIScrollView alloc] initWithFrame:CGRectZero] autorelease];
        feetScrollView.pagingEnabled = YES;
        [self addSubview:feetScrollView];
        [self fillScrollView:feetScrollView fromFolder:@"feet"];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat scrollViewHeight = height/3.0;
    CGFloat contentWidth = [imageNames count]*width;
    
    headsScrollView.frame  = CGRectMake(0.0, 0.0, width, scrollViewHeight);
    headsScrollView.contentSize = CGSizeMake(contentWidth, scrollViewHeight);
    CGFloat xOffset = 0.0;
    for (UIView * view in headsScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.frame = CGRectMake(xOffset, 0.0, width, scrollViewHeight);
            xOffset += width;
        }
    }
   
    xOffset = 0.0;
    bodiesScrollView.frame = CGRectMake(0.0, scrollViewHeight, width, scrollViewHeight);
    bodiesScrollView.contentSize = CGSizeMake(contentWidth, scrollViewHeight);
    for (UIView * view in bodiesScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.frame = CGRectMake(xOffset, 0.0, width, scrollViewHeight);
            xOffset += width;
        }
    }
   
    xOffset = 0.0;
    feetScrollView.frame   = CGRectMake(0.0, scrollViewHeight*2.0, width, scrollViewHeight);
    feetScrollView.contentSize = CGSizeMake(contentWidth, scrollViewHeight);
    for (UIView * view in feetScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.frame = CGRectMake(xOffset, 0.0, width, scrollViewHeight);
            xOffset += width;
        }
    }
}

- (void)fillScrollView:(UIScrollView*)scrollView fromFolder:(NSString*)folder {
    for (NSString * imageName in imageNames) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@.png", folder, imageName]];
        [scrollView addSubview:imgView];
    }
}

@end

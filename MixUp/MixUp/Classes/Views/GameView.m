//
//  GameView.m
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "GameView.h"
#import "InfiniteScrollView.h"
#import "ImageManager.h"

@interface GameView ()


@end

@implementation GameView



- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
    
        headsScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:headsScrollView];
        [headsScrollView displayImages:[[ImageManager sharedManager] headsImages]];
         
        bodiesScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:bodiesScrollView];
        [bodiesScrollView displayImages:[[ImageManager sharedManager] bodiesImages]];

        feetScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:feetScrollView];
        [feetScrollView displayImages:[[ImageManager sharedManager] feetImages]];
      
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
  
    headsScrollView.frame   = CGRectMake(0.0, 0.0, self.frame.size.width, [[ImageManager sharedManager] headImageHeight]);
    bodiesScrollView.frame  = CGRectMake(0.0, headsScrollView.frame.size.height, self.frame.size.width, [[ImageManager sharedManager] bodyImageHeight]);
    feetScrollView.frame    = CGRectMake(0.0, bodiesScrollView.frame.size.height+bodiesScrollView.frame.origin.y, self.frame.size.width, [[ImageManager sharedManager] feetImageHeight]);
}


@end

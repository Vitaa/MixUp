//
//  GameView.m
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Al Digit. All rights reserved.
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
    
        headsScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, [[ImageManager sharedManager] headImageHeight])] autorelease];
        [self addSubview:headsScrollView];
        [headsScrollView displayImages:[[ImageManager sharedManager] headsImages]];
         
        bodiesScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectMake(0.0, headsScrollView.frame.size.height, 320.0, [[ImageManager sharedManager] bodyImageHeight])] autorelease];
        [self addSubview:bodiesScrollView];
        [bodiesScrollView displayImages:[[ImageManager sharedManager] bodiesImages]];

        feetScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectMake(0.0, bodiesScrollView.frame.size.height+bodiesScrollView.frame.origin.y, 320.0, [[ImageManager sharedManager] feetImageHeight])] autorelease];
        [self addSubview:feetScrollView];
        [feetScrollView displayImages:[[ImageManager sharedManager] feetImages]];
      
    }
    return self;
}


@end

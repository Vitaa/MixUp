//
//  GameView.h
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 MixUp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfiniteScrollView;

@interface GameView : UIView {
    InfiniteScrollView * headsScrollView;
    InfiniteScrollView * bodiesScrollView;
    InfiniteScrollView * feetScrollView;
}


@end

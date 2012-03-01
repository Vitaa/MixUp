//
//  GameView.h
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfiniteScrollView;

@interface AnimalsView : UIView {
    InfiniteScrollView * headsScrollView;
    InfiniteScrollView * bodiesScrollView;
    InfiniteScrollView * feetScrollView;
}

- (NSArray*)currentAnimals;

@end

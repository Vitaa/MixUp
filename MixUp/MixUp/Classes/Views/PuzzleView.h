//
//  PuzzleView.h
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameState.h"
#import "AbsractView.h"

@class AnimalsView;
@class PuzzleView;

@protocol PuzzleViewProtocol <NSObject>

@optional
- (void)puzzleView:(PuzzleView*)gameView checkPressedWithAnimalsState:(GameState*)animals;
- (void)puzzleViewBackButtonPressed:(PuzzleView*)gameView;

@end

@interface PuzzleView : AbsractView {
    AnimalsView * animalsView;
    UIButton * checkBtn;

    UIImageView * cloudView;
    UILabel  * timer;
}

- (void)initShuffle;
- (void)setTime:(NSString*)time;
- (void)setTimeColor:(UIColor*)timeColor;
- (void)initialize;

@property (nonatomic, assign) id <PuzzleViewProtocol> delegate;

@end

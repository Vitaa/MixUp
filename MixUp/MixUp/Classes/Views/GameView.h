//
//  GameView.h
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameState.h"
#import "AbsractView.h"

@class AnimalsView;
@class GameView;

@protocol GameViewProtocol <NSObject>

@optional
- (void)gameView:(GameView*)gameView whoAmIPressedWithAnimalsState:(GameState*)animals;
- (void)gameViewBackButtonPressed:(GameView*)gameView;

@end

@interface GameView : AbsractView {
    AnimalsView * animalsView;
    UIButton * whoAmIBtn;
}

@property (nonatomic, assign) id <GameViewProtocol> delegate;

@end

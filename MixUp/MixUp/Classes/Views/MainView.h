//
//  MainView.h
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView;

@protocol MainViewDelegate <NSObject>

@optional
- (void)mainViewGuessButtonPressed:(MainView*)mainView;
- (void)mainViewCombineButtonPressed:(MainView *)mainView;
- (void)mainViewAboutButtonPressed:(MainView *)mainView;

@end

@interface MainView : UIView {
    UIButton * guessButton;
    UIButton * combineButton;
    UIButton * aboutButton;
#ifdef LITE
    UIButton * fullVersionButton;
#endif
    
    UIImageView * topLogo;
    UIImageView * bottomLogo;
}

@property (nonatomic, assign) id <MainViewDelegate> delegate;

@end

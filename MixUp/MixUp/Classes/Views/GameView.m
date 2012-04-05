//
//  GameView.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "GameView.h"
#import "AnimalsView.h"


@implementation GameView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        animalsView = [[[AnimalsView alloc] init] autorelease];
        [self addSubview:animalsView];
        
        UIImage * whoAmIImg = [UIImage imageNamed:@"who_am_i_button_normal"];
        whoAmIBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, whoAmIImg.size.width, whoAmIImg.size.height)] autorelease];
        [whoAmIBtn setBackgroundImage:whoAmIImg forState:UIControlStateNormal];
        [whoAmIBtn addTarget:self action:@selector(whoAmI:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:whoAmIBtn];
        
        [self bringSubviewToFront:backBtn];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    animalsView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
    CGRect btnFrame = whoAmIBtn.frame;
    btnFrame.origin.y = self.frame.size.height - btnFrame.size.height - 5.0;
    btnFrame.origin.x = (self.frame.size.width - btnFrame.size.width) / 2.0;
    if (is_iPad)
        btnFrame.origin.y -= 5.0;
    whoAmIBtn.frame = btnFrame;
}

- (void)whoAmI:(id)sender {
    if ([delegate respondsToSelector:@selector(gameView:whoAmIPressedWithAnimalsState:)])
        [delegate gameView:self whoAmIPressedWithAnimalsState:[animalsView currentAnimalsState]];
}

- (void)onBack:(id)sender {
    if ([delegate respondsToSelector:@selector(gameViewBackButtonPressed:)])
        [delegate gameViewBackButtonPressed:self];
}

- (void)shuffleAnimated:(BOOL)animated {
    [animalsView shuffleAnimated:animated];
}

- (void)initialize {
    [animalsView initialize];
}

@end

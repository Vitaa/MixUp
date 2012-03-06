//
//  PuzzleView.m
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "PuzzleView.h"
#import "AnimalsView.h"

@implementation PuzzleView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        animalsView = [[[AnimalsView alloc] init] autorelease];
        [self addSubview:animalsView];
        
        UIImage * checkImg = [UIImage imageNamed:@"check_button_normal.png"];
        checkBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, checkImg.size.width, checkImg.size.height)] autorelease];
        [checkBtn setBackgroundImage:checkImg forState:UIControlStateNormal];
        [checkBtn addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkBtn];
        
        timer = [[UILabel alloc] initWithFrame:CGRectZero];
        timer.backgroundColor = [UIColor clearColor];
        timer.textColor = [UIColor whiteColor];
        timer.font = [UIFont systemFontOfSize:20.0];
        timer.shadowColor = [UIColor darkGrayColor];
        timer.shadowOffset = CGSizeMake(1.0, 1.0); 
        timer.textAlignment = UITextAlignmentRight;
        timer.text = @"5:00";
        [self addSubview:timer];
        
        [self bringSubviewToFront:backBtn];
    }
    return self;
}

- (void)initShuffle {
    [animalsView shuffleAnimated:YES];
}

- (void)initialize {
    [animalsView initialize];
}

- (void)setTime:(NSString*)time {
    timer.text = time;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    animalsView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
    CGRect btnFrame = checkBtn.frame;
    btnFrame.origin.y = self.frame.size.height - btnFrame.size.height - 5.0;
    btnFrame.origin.x = (self.frame.size.width - btnFrame.size.width) / 2.0;
    checkBtn.frame = btnFrame;
    
    timer.frame = CGRectMake(0.0, 10.0, self.frame.size.width-10.0, 20.0);
}

- (void)onCheck:(id)sender {
    if ([delegate respondsToSelector:@selector(puzzleView:checkPressedWithAnimalsState:)])
        [delegate puzzleView:self checkPressedWithAnimalsState:[animalsView currentAnimalsState]];
}

- (void)onBack:(id)sender {
    if ([delegate respondsToSelector:@selector(puzzleViewBackButtonPressed:)])
        [delegate puzzleViewBackButtonPressed:self];
}


@end

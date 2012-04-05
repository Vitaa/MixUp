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
        
        UIImage * checkImg = [UIImage imageNamed:@"check_button_normal"];
        checkBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, checkImg.size.width, checkImg.size.height)] autorelease];
        [checkBtn setBackgroundImage:checkImg forState:UIControlStateNormal];
        [checkBtn addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkBtn];
        
        cloudView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]] autorelease];
        [self addSubview:cloudView];
        
        timer = [[UILabel alloc] initWithFrame:CGRectZero];
        timer.backgroundColor = [UIColor clearColor];
        timer.textColor = [UIColor whiteColor]; 
        timer.textAlignment = UITextAlignmentRight;
        timer.text = @"05:00";
        timer.font = [UIFont systemFontOfSize:is_iPad?40.0:20];
  
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

- (void)setTimeColor:(UIColor*)timeColor {
    timer.textColor = timeColor;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    animalsView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
    CGRect btnFrame = checkBtn.frame;
    btnFrame.origin.y = self.frame.size.height - btnFrame.size.height - 5.0;
    btnFrame.origin.x = (self.frame.size.width - btnFrame.size.width) / 2.0;
    if (is_iPad)
        btnFrame.origin.y -= 5.0;
    checkBtn.frame = btnFrame;
    
    timer.frame = is_iPad?CGRectMake(0.0, 33.0, self.frame.size.width-35.0, 40.0):CGRectMake(0.0, 17.0, self.frame.size.width-17.0, 20.0);
    cloudView.frame = CGRectMake(self.frame.size.width-cloudView.frame.size.width, 0.0, cloudView.frame.size.width, cloudView.frame.size.height);
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

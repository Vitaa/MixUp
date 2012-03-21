//
//  AbsractView.m
//  MixUp
//
//  Created by Vita on 3/6/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AbsractView.h"

@implementation AbsractView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           
        UIImage * backImg = [UIImage imageNamed:@"back"];
        backBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, backImg.size.width, backImg.size.height)] autorelease];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];

    CGRect backFrame = backBtn.frame;
    backFrame.origin.x = 10.0;
    backFrame.origin.y = 10.0;
    backBtn.frame = backFrame;
}

- (void)onBack:(id)sender {
}

@end

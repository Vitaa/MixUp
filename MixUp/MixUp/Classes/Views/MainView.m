//
//  MainView.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "MainView.h"

@implementation MainView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {      
        UIImage * combineImg = [UIImage imageNamed:@"combine_button_normal"];
        
        combineButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, combineImg.size.width, combineImg.size.height)] autorelease];
        [combineButton setBackgroundImage:combineImg forState:UIControlStateNormal];
        [combineButton addTarget:self action:@selector(onCombine:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:combineButton];
        
        guessButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, combineImg.size.width, combineImg.size.height)] autorelease];
        [guessButton setBackgroundImage:[UIImage imageNamed:@"guess_button_normal"] forState:UIControlStateNormal];
        [guessButton addTarget:self action:@selector(onGuess:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:guessButton];
        
        aboutButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, combineImg.size.width, combineImg.size.height)] autorelease];
        [aboutButton setBackgroundImage:[UIImage imageNamed:@"about_us_button_normal"] forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(onAbout:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:aboutButton];
        
#ifdef LITE
        UIImage * fullImg = [UIImage imageNamed:@"full_version_normal"];
        fullVersionButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, fullImg.size.width, fullImg.size.height)] autorelease];
        [fullVersionButton setBackgroundImage:fullImg forState:UIControlStateNormal];
        [fullVersionButton addTarget:self action:@selector(onFullVersion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fullVersionButton];
#endif
        
        topLogo = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]]  autorelease];
        [self addSubview:topLogo];
        
        bottomLogo = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_bottom"]] autorelease];
        [self addSubview:bottomLogo];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    
    topLogo.frame = CGRectMake((width-topLogo.image.size.width)/2, 10.0, topLogo.frame.size.width, topLogo.frame.size.height);
    bottomLogo.frame = CGRectMake(0.0, self.frame.size.height-bottomLogo.frame.size.height, bottomLogo.frame.size.width, bottomLogo.frame.size.height);
    
    CGFloat offset = 20.0;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        offset += 20.0;
    }
    CGFloat btnOffset = 20.0;
#ifdef LITE
    btnOffset = 10.0;
    offset -= 10.0;
#endif
    
    CGSize btnSize = combineButton.frame.size;
    guessButton.frame = CGRectMake((width-btnSize.width)/2, topLogo.frame.size.height+topLogo.frame.origin.y+offset, btnSize.width, btnSize.height);
    combineButton.frame = CGRectMake((width-btnSize.width)/2, guessButton.frame.origin.y + guessButton.frame.size.height + btnOffset, btnSize.width, btnSize.height);
    CGFloat yAboutOffset = combineButton.frame.origin.y + combineButton.frame.size.height + btnOffset;
#ifdef LITE
    fullVersionButton.frame = CGRectMake((width-btnSize.width)/2, yAboutOffset-10.0, fullVersionButton.frame.size.width, fullVersionButton.frame.size.height);
    yAboutOffset = fullVersionButton.frame.origin.y + fullVersionButton.frame.size.height + btnOffset;
#endif
    aboutButton.frame = CGRectMake((width-btnSize.width)/2, yAboutOffset, btnSize.width, btnSize.height);
}

- (void)onCombine:(id)sender {
    if ([delegate respondsToSelector:@selector(mainViewCombineButtonPressed:)])
        [delegate mainViewCombineButtonPressed:self];
}

- (void)onGuess:(id)sender {
    if ([delegate respondsToSelector:@selector(mainViewGuessButtonPressed:)])
        [delegate mainViewGuessButtonPressed:self];
}

- (void)onAbout:(id)sender {
    if ([delegate respondsToSelector:@selector(mainViewAboutButtonPressed:)])
        [delegate mainViewAboutButtonPressed:self];
}

- (void)onFullVersion:(id)sender {

}


@end

//
//  GameView.m
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AnimalsView.h"
#import "InfiniteScrollView.h"
#import "ImageManager.h"

@interface AnimalsView ()
- (NSInteger)decodeCurrentIndex:(NSInteger)index;

@end

@implementation AnimalsView



- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        headsScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:headsScrollView];
        [headsScrollView displayImages:[[ImageManager sharedManager] headsImages]];
         
        bodiesScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:bodiesScrollView];
        [bodiesScrollView displayImages:[[ImageManager sharedManager] bodiesImages]];

        feetScrollView = [[[InfiniteScrollView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:feetScrollView];
        [feetScrollView displayImages:[[ImageManager sharedManager] feetImages]];
      
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
  
    headsScrollView.frame   = CGRectMake(0.0, -30.0, self.frame.size.width, [[ImageManager sharedManager] headImageHeight]);
    bodiesScrollView.frame  = CGRectMake(0.0, headsScrollView.frame.origin.y + headsScrollView.frame.size.height, self.frame.size.width, [[ImageManager sharedManager] bodyImageHeight]);
    feetScrollView.frame    = CGRectMake(0.0, bodiesScrollView.frame.size.height+bodiesScrollView.frame.origin.y, self.frame.size.width, [[ImageManager sharedManager] feetImageHeight]);
}


- (GameState*)currentAnimalsState {
    NSInteger topAnimal    = [self decodeCurrentIndex:[headsScrollView currentImageIndex]];
    NSInteger middleAnimal = [self decodeCurrentIndex:[bodiesScrollView currentImageIndex]];
    NSInteger bottomAnimal = [self decodeCurrentIndex:[feetScrollView currentImageIndex]];
    
    NSString* topAnimalName = [[ImageManager sharedManager] animalNameForIndex:topAnimal];
    NSString* middleAnimalName = [[ImageManager sharedManager] animalNameForIndex:middleAnimal];
    NSString* bottomAnimalName = [[ImageManager sharedManager] animalNameForIndex:bottomAnimal];
    
    GameState * state = [GameState new];
    state.topAnimal = topAnimalName;
    state.middleAnimal = middleAnimalName;
    state.bottomAnimal = bottomAnimalName;
    
    return [state autorelease];
}

- (void)suffleAnimated:(BOOL)animated {
    NSInteger count = [[ImageManager sharedManager] animalCount];
    [headsScrollView scrollToPage:arc4random() % count animated:animated];
    [bodiesScrollView scrollToPage:arc4random() % count animated:animated];
    [feetScrollView scrollToPage:arc4random() % count animated:animated];
}

#pragma mark - private
- (NSInteger)decodeCurrentIndex:(NSInteger)index {
    NSInteger count = [[[ImageManager sharedManager] feetImages] count];
    if (index==0)
        return count-1;
    if (index==count+1)
        return 0;
    return index-1;
}

@end

//
//  Puzzle.m
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "Puzzle.h"
#import "ImageManager.h"

@interface Puzzle ()
@property (nonatomic, retain)GameState * state;

- (void)initFirstLevel;
- (void)initSecondLevel;
- (void)initThirdLevel;

@end

@implementation Puzzle

@synthesize state;

- (id) initWithLevel:(NSInteger)level {
    if (self = [super init]) {
        state = [[GameState alloc] init];
        switch (level) {
            case 1:
                [self initFirstLevel];
                break;
            case 2:
                [self initSecondLevel];
                break;
            case 3:
                [self initThirdLevel];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)dealloc {
    [state release];
    [super dealloc];
}

- (GameState*)gameState {
    return state;
}

#pragma mark - private
- (void)initFirstLevel {
    NSInteger count = [[ImageManager sharedManager] animalCount];
    int picture = arc4random() % count;
    NSString * name = [[ImageManager sharedManager] animalNameForIndex:picture];
    state.topAnimal = name;
    state.middleAnimal = name;
    state.bottomAnimal = name;
}

- (void)initSecondLevel {
    NSInteger count = [[ImageManager sharedManager] animalCount];
    int firstPic = arc4random() % count;
    int lastPic = firstPic;
    int middlePic = firstPic;
	
    while(lastPic == firstPic) {
        lastPic = arc4random() % count;
    }
    
    Boolean isMiddleForFirst = arc4random() % 2;
    if(isMiddleForFirst) {
        middlePic = firstPic;
    } else {
        middlePic = lastPic;
    }
    state.topAnimal = [[ImageManager sharedManager] animalNameForIndex:firstPic];
    state.middleAnimal = [[ImageManager sharedManager] animalNameForIndex:middlePic];
    state.bottomAnimal = [[ImageManager sharedManager] animalNameForIndex:lastPic];
}

- (void)initThirdLevel {
    NSInteger count = [[ImageManager sharedManager] animalCount];
    int firstPic = arc4random() % count;
    int lastPic = firstPic;
    int middlePic = firstPic;
    
    while(lastPic == firstPic) {
        lastPic = arc4random() % count;
    }
    
    while(middlePic == firstPic || middlePic == lastPic) {
        middlePic = arc4random() % count;
    }
    state.topAnimal = [[ImageManager sharedManager] animalNameForIndex:firstPic];
    state.middleAnimal = [[ImageManager sharedManager] animalNameForIndex:middlePic];
    state.bottomAnimal = [[ImageManager sharedManager] animalNameForIndex:lastPic];
}

- (BOOL)check:(GameState*)gameState {
    return [state isEqual:gameState];
}


@end

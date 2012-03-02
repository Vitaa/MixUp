//
//  Puzzle.h
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"

@interface Puzzle : NSObject

- (id) initWithLevel:(NSInteger)level;

- (GameState*)gameState; 
- (BOOL)check:(GameState*)gameState;

@end

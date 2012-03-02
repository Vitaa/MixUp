//
//  GameState.m
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "GameState.h"

@implementation GameState

@synthesize topAnimal, middleAnimal, bottomAnimal;

- (void)dealloc {
    [topAnimal release];
    [middleAnimal release];
    [bottomAnimal release];
    
    [super dealloc];
}

- (BOOL)isEqualToState:(GameState *)state {
    if (self == state)
        return YES;
    if ([topAnimal isEqualToString:state.topAnimal] && [middleAnimal isEqualToString:state.middleAnimal] && [bottomAnimal isEqualToString:state.bottomAnimal])
        return YES;
    return NO;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToState:other];
}



@end

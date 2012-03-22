//
//  AudioManager.h
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AVFoundation/AVFoundation.h"
#import "GameState.h"

@interface AudioManager : NSObject <AVAudioPlayerDelegate>
{
    AVAudioPlayer * player;
    NSTimer * timer;
}

+ (AudioManager*)sharedManager;

- (void)playSoundsForAnimalWithState:(GameState*)state;
- (void)playPuzzleSoundsFromAnimalWithState:(GameState*)state;
- (void)playNextPuzzleSoundsFromAnimalWithState:(GameState*)state;
- (void)playNotCorrectSound:(GameState*)state;
- (void)playTimeoutSound;
- (void)playWinSound;

- (void)prepare;

@end

//
//  AudioManager.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AudioManager.h"

@interface AudioManager ()
- (NSArray*)soundNamesForAnimalsState:(GameState*)state;
- (void)playNextSound;
- (NSURL*)urlForSoundName:(NSString*)name;

@property (nonatomic, retain) NSArray   * sounds;
@property (nonatomic, assign) NSInteger currentSound;
@property (nonatomic, retain) NSArray   * winSounds;
@property (nonatomic, retain) NSArray   * loseSounds;
@end

@implementation AudioManager

@synthesize sounds, winSounds, loseSounds, currentSound;

#pragma mark - singleton

+ (AudioManager*)sharedManager{
    static AudioManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AudioManager new];
    });
    return instance;
}


#pragma mark - init/dealloc
- (id) init {
    if ((self=[super init])) {
        winSounds  = [[NSArray alloc] initWithObjects:@"good_boy", @"good_job", @"its_correct", @"its_good", @"well_done", nil];
        loseSounds = [[NSArray alloc] initWithObjects:@"not_right", @"not_right2", nil]; 
    }
    return self;
}

- (void)dealloc {
    [sounds release];
    [winSounds release];
    [loseSounds release];
    [super dealloc];
}

#pragma mark - public
- (void)prepare {
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self urlForSoundName:[winSounds objectAtIndex:0]] error:nil];
    [player prepareToPlay];
}


- (void)playSoundsForAnimalWithState:(GameState*)state {
    NSMutableArray * sounds_ = [NSMutableArray arrayWithArray:[self soundNamesForAnimalsState:state]];
    [sounds_ insertObject:@"this_is" atIndex:0];
    self.sounds = sounds_;
    self.currentSound = 0;
    if (player && [player isPlaying])
        [player stop];
    [self playNextSound];
}

- (void)playPuzzleSoundsFromAnimalWithState:(GameState*)state {
    NSMutableArray * sounds_ = [NSMutableArray arrayWithArray:[self soundNamesForAnimalsState:state]];
    [sounds_ insertObject:@"how_it_looks" atIndex:0];
    self.sounds = sounds_;
    self.currentSound = 0;
    if (player && [player isPlaying])
        [player stop];
    [self playNextSound];
}

- (void)playNextPuzzleSoundsFromAnimalWithState:(GameState*)state {
    NSMutableArray * sounds_ = [NSMutableArray arrayWithArray:[self soundNamesForAnimalsState:state]];
    NSInteger winSound = arc4random() % [winSounds count];
    [sounds_ insertObject:[winSounds objectAtIndex:winSound] atIndex:0];
    [sounds_ insertObject:@"how_it_looks" atIndex:1];
    self.sounds = sounds_;
    self.currentSound = 0;
    if (player && [player isPlaying])
        [player stop];
    [self playNextSound];
}

- (void)playNotCorrectSound:(GameState*)state {
    if (player && [player isPlaying])
        return;
    NSMutableArray * sounds_ = [NSMutableArray arrayWithArray:[self soundNamesForAnimalsState:state]];
    NSInteger loseSound = arc4random() % [loseSounds count];
    [sounds_ insertObject:[loseSounds objectAtIndex:loseSound] atIndex:0];
    [sounds_ insertObject:@"how_it_looks" atIndex:1];
    self.sounds = sounds_;
    self.currentSound = 0;
    [self playNextSound];
}

- (void)playTimeoutSound {
    if (player && [player isPlaying])
        [player stop];
    self.sounds = [NSArray arrayWithObject:@"loose"];
    self.currentSound = 0;
    [self playNextSound];
}

- (void)playWinSound {
    if (player && [player isPlaying])
        [player stop];
    self.sounds = [NSArray arrayWithObject:@"win"];
    self.currentSound = 0;
    [self playNextSound];
}

#pragma mark - AudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    currentSound++;
//    [self playNextSound];
}

- (void)onTimer:(id)sender {
    currentSound++;
    [self playNextSound];
}

#pragma mark - private
- (NSURL*)urlForSoundName:(NSString*)name {
    return [[NSBundle mainBundle] URLForResource:name withExtension:@"wav"];
}

- (void) playNextSound {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    if (currentSound < [sounds count]) {
        if (player) {
            [player stop];
            [player release];
        }
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self urlForSoundName:[sounds objectAtIndex:currentSound]] error:nil];
//        player.delegate = self;
        [player play];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:player.duration-0.25 target:self selector:@selector(onTimer:) userInfo:nil repeats:NO];
    }
}
 
- (NSArray*)soundNamesForAnimalsState:(GameState*)state {
    NSString* topAnimal    = state.topAnimal;
    NSString* middleAnimal = state.middleAnimal;
    NSString* bottomAnimal = state.bottomAnimal;
    
    if ([topAnimal isEqualToString:middleAnimal]) {
        if ([topAnimal isEqualToString:bottomAnimal]) {
            return [NSArray arrayWithObject:[NSString stringWithFormat:@"%@_full", topAnimal]];
        }
        else
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part", topAnimal],
                    [NSString stringWithFormat:@"%@_full", bottomAnimal], nil];
    }
    else {
        if ([middleAnimal isEqualToString:bottomAnimal]){
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part", topAnimal],
                    [NSString stringWithFormat:@"%@_full", bottomAnimal], nil];
        }
        else {
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part", topAnimal],
                    [NSString stringWithFormat:@"%@_part", middleAnimal],
                    [NSString stringWithFormat:@"%@_full", bottomAnimal], nil];
        }
    }
}

@end

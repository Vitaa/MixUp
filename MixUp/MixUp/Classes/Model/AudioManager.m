//
//  AudioManager.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AudioManager.h"

@interface AudioManager ()
- (NSArray*)soundNamesForAnimals:(NSArray*)names;
- (void)playNextSound;

@property (nonatomic, retain) NSArray   * sounds;
@property (nonatomic, assign) NSInteger currentSound;
@end

@implementation AudioManager

@synthesize sounds, currentSound;

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
    }
    return self;
}

#pragma mark - public
- (void)playSoundsForAnimalWithNames:(NSArray*)names {
    NSMutableArray * sounds_ = [NSMutableArray arrayWithArray:[self soundNamesForAnimals:names]];
    [sounds_ insertObject:@"this_is" atIndex:0];
    self.sounds = sounds_;
    self.currentSound = 0;
    if (player && [player isPlaying])
        [player stop];
    [self playNextSound];
}

#pragma mark - AudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    currentSound++;
    [self playNextSound];
}


#pragma mark - private
- (NSURL*)urlForSoundName:(NSString*)name {
    return [[NSBundle mainBundle] URLForResource:name withExtension:@"wav"];
}

- (void) playNextSound {
    if (currentSound < [sounds count]) {
        if (player) {
            [player release];
        }
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self urlForSoundName:[sounds objectAtIndex:currentSound]] error:nil];
        player.delegate = self;
        [player play];
    }
}
 
- (NSArray*)soundNamesForAnimals:(NSArray*)names {
    NSString* topAnimal    = [names objectAtIndex:0];
    NSString* middleAnimal = [names objectAtIndex:1];
    NSString* bottomAnimal = [names objectAtIndex:2];
    
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

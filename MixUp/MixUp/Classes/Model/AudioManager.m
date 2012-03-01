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
@end

@implementation AudioManager

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
    NSMutableArray * sounds = [NSMutableArray arrayWithArray:[self soundNamesForAnimals:names]];
    [sounds insertObject:@"this_is.wav" atIndex:0];
    
}


#pragma mark - private
- (void) playSounds:(NSArray*)sounds index:(NSInteger)soundIndex {
    if (soundIndex < [sounds count]) {
       // AVAudioPlayer * audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:<#(NSURL *)#> error:<#(NSError **)#>];
    }
}
 
- (NSArray*)soundNamesForAnimals:(NSArray*)names {
    NSString* topAnimal    = [names objectAtIndex:0];
    NSString* middleAnimal = [names objectAtIndex:1];
    NSString* bottomAnimal = [names objectAtIndex:2];
    
    if ([topAnimal isEqualToString:middleAnimal]) {
        if ([topAnimal isEqualToString:bottomAnimal]) {
            return [NSArray arrayWithObject:[NSString stringWithFormat:@"%@_full.wav", topAnimal]];
        }
        else
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part.wav", topAnimal],
                    [NSString stringWithFormat:@"%@_full.wav", bottomAnimal], nil];
    }
    else {
        if ([middleAnimal isEqualToString:bottomAnimal]){
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part.wav", topAnimal],
                    [NSString stringWithFormat:@"%@_full.wav", bottomAnimal], nil];
        }
        else {
            return [NSArray arrayWithObjects:
                    [NSString stringWithFormat:@"%@_part.wav", topAnimal],
                    [NSString stringWithFormat:@"%@_part.wav", middleAnimal],
                    [NSString stringWithFormat:@"%@_full.wav", bottomAnimal], nil];
        }
    }
}

@end

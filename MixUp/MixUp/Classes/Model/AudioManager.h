//
//  AudioManager.h
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AVFoundation/AVFoundation.h"

@interface AudioManager : NSObject <AVAudioPlayerDelegate>
{
}

+ (AudioManager*)sharedManager;

- (void)playSoundsForAnimalWithNames:(NSArray*)names;

@end

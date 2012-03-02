//
//  ImageManager.h
//  MixUp
//
//  Created by Vita on 2/29/12.
//  Copyright (c) Mix Up. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

+ (ImageManager*)sharedManager;

- (NSArray*)headsImages;
- (NSArray*)bodiesImages;
- (NSArray*)feetImages;

- (CGFloat)headImageHeight;
- (CGFloat)bodyImageHeight;
- (CGFloat)feetImageHeight;

- (NSString*)animalNameForIndex:(NSInteger)index;
- (NSInteger)animalCount;

@end

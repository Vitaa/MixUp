//
//  ImageManager.m
//  MixUp
//
//  Created by Vita on 2/29/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "ImageManager.h"
#import "UIImage+ContentsOfFile.h"

@interface ImageManager() 

- (NSArray *)animalPartsFromArray:(NSArray*)animals withPrefix:(NSString*)prefix;

@property (nonatomic, retain) NSArray * headsImagePaths;
@property (nonatomic, retain) NSArray * bodiesImagePaths;
@property (nonatomic, retain) NSArray * feetImagePaths;

@property (nonatomic, assign) CGFloat headImgHeight;
@property (nonatomic, assign) CGFloat bodyImgHeight;
@property (nonatomic, assign) CGFloat feetImgHeight;

@end

@implementation ImageManager

@synthesize headsImagePaths, bodiesImagePaths, feetImagePaths;
@synthesize headImgHeight, bodyImgHeight, feetImgHeight;

#pragma mark - singleton

+ (ImageManager*)sharedManager{
    static ImageManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ImageManager new];
    });
    return instance;
}

#pragma mark - init/dealloc

- (id) init {
    if ((self = [super init])) {
        NSString * basePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"base"];
        NSArray * baseAnimals = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:nil];
        NSMutableArray * animals = [NSMutableArray array];
        for (NSString * animal in baseAnimals) {
            [animals addObject:[NSString stringWithFormat:@"base/%@", animal]];
        }
        
#ifndef LITE
        NSString * additionPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"addition"];
        NSArray * additionAnimals = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:additionPath error:nil];
        for (NSString * animal in additionAnimals) {
            [animals addObject:[NSString stringWithFormat:@"addition/%@", animal]];
        }
#endif
        
        self.headsImagePaths  = [self animalPartsFromArray:animals withPrefix:@"head"];
        self.bodiesImagePaths = [self animalPartsFromArray:animals withPrefix:@"body"];
        self.feetImagePaths   = [self animalPartsFromArray:animals withPrefix:@"feet"];
    }
    return self;
}

- (void) dealloc {
    [headsImagePaths  release];
    [bodiesImagePaths release];
    [feetImagePaths   release];
    
    [super dealloc];
}

#pragma mark - public

- (NSArray*)headsImages {
    NSMutableArray * images = [NSMutableArray array];
    for (NSString * path in headsImagePaths){
        [images addObject:[UIImage imageNamed:path]/*[UIImage imageWithContentsOfResolutionIndependentFile:path]*/];
    }
    return images;
}

- (NSArray*)bodiesImages {
    NSMutableArray * images = [NSMutableArray array];
    for (NSString * path in bodiesImagePaths){
        [images addObject:[UIImage imageNamed:path]/*[UIImage imageWithContentsOfResolutionIndependentFile:path]*/];
    }
    return images;
}

- (NSArray*)feetImages {
    NSMutableArray * images = [NSMutableArray array];
    for (NSString * path in feetImagePaths){
        [images addObject:[UIImage imageNamed:path]/*[UIImage imageWithContentsOfResolutionIndependentFile:path]*/];
    }
    return images;
}

- (CGFloat)headImageHeight {
    if (headImgHeight != 0.0)
        return headImgHeight;
    headImgHeight = [UIImage imageNamed:[headsImagePaths lastObject]].size.height;
    //[UIImage imageWithContentsOfResolutionIndependentFile:[headsImagePaths lastObject]].size.height;
    return headImgHeight;
}

- (CGFloat)bodyImageHeight {
    if (bodyImgHeight != 0.0)
        return bodyImgHeight;
    bodyImgHeight = [UIImage imageNamed:[bodiesImagePaths lastObject]].size.height;
    //[UIImage imageWithContentsOfResolutionIndependentFile:[bodiesImagePaths lastObject]].size.height;

    return bodyImgHeight;
}

- (CGFloat)feetImageHeight {
    if (feetImgHeight != 0.0)
        return feetImgHeight;
    feetImgHeight = [UIImage imageNamed:[feetImagePaths lastObject]].size.height;
    //[UIImage imageWithContentsOfResolutionIndependentFile:[feetImagePaths lastObject]].size.height;
    return feetImgHeight;

}

- (NSString*)animalNameForIndex:(NSInteger)index {
    NSString * fileName = [[feetImagePaths objectAtIndex:index] lastPathComponent];
    NSInteger _loc = [fileName rangeOfString:@"_"].location;
    return [fileName substringToIndex:_loc];
}

- (NSInteger)animalCount {
    return [feetImagePaths count];
}

#pragma  mark - private
- (NSArray *)animalPartsFromArray:(NSArray*)animals withPrefix:(NSString*)prefix {
    NSArray * heads = [animals filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"self contains[c] %@ AND not self contains[c] '~iphone' AND not self contains[c] '2x'", prefix]];
    NSMutableArray * headsFullPaths = [NSMutableArray array];
    for (NSString * path in heads) {
        path = [path substringToIndex:[path rangeOfString:@"~ipad"].location];
        [headsFullPaths addObject:path /*[fullPath stringByAppendingPathComponent:path]*/];
    }
#ifdef LITE
#endif
    
    return headsFullPaths;
}

@end

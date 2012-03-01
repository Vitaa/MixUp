//
//  UIImage+ContentsOfFile.h
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ContentsOfFile)
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;
@end

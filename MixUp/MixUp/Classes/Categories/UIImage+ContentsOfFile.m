//
//  UIImage+ContentsOfFile.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "UIImage+ContentsOfFile.h"

@implementation UIImage (ContentsOfFile)

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [self initWithData:[NSData dataWithContentsOfFile:path]];
    }
    else {
        if ([[UIScreen mainScreen] scale] == 2.0) { // retina
            NSString *path2x = [[path stringByDeletingLastPathComponent] 
                                stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone@2x.%@", 
                                                                [[path lastPathComponent] stringByDeletingPathExtension], 
                                                                [path pathExtension]]];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:path2x]) {
                return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
            }
        }
        else {
            NSString *path1x =  [[path stringByDeletingLastPathComponent] 
                               stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.%@", 
                                                               [[path lastPathComponent] stringByDeletingPathExtension], 
                                                               [path pathExtension]]];
            return [self initWithData:[NSData dataWithContentsOfFile:path1x]];
        }
    }
    
    return nil;
}

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path {
    return [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
}

@end

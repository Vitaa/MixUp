//
//  NSDate+Time.m
//  MixUp
//
//  Created by Vita on 3/5/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

- (NSString*)timeString {
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"mm:ss"];
    return [formatter stringFromDate:self];
}

@end

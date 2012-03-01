//
//  InfiniteScrollView.m
//  MixUp
//
//  Created by Vita on 2/28/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "InfiniteScrollView.h"

@implementation InfiniteScrollView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.showsVerticalScrollIndicator   = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate                       = self;
        self.pagingEnabled                  = YES;     
    }
    return self;
}

- (void)displayImages:(NSArray*)images {

    UIImageView * imgView = [[[UIImageView alloc] initWithImage:[images lastObject]] autorelease];
    [self addSubview:imgView];
    
    for (int i=0; i < [images count]; i++) {
        UIImageView * imgView = [[[UIImageView alloc] initWithImage:[images objectAtIndex:i]] autorelease];
        [self addSubview:imgView];
    }
    imgView = [[[UIImageView alloc] initWithImage:[images objectAtIndex:0]] autorelease];
    [self addSubview:imgView];
    
    [self setNeedsLayout];
}

- (NSInteger)currentImageIndex {
    return self.contentOffset.x / self.frame.size.width;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat xOffset = 0.0;
    CGFloat width   = self.frame.size.width;
    CGFloat height  = self.frame.size.height;
    
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            UIImageView * imgView = (UIImageView*)subview;
            imgView.frame = CGRectMake(xOffset, 0.0, width, height);
            xOffset += width;
        }
    }
    
    self.contentSize = CGSizeMake(xOffset+width, self.frame.size.height);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    int page = self.contentOffset.x / self.frame.size.width;
    int pageCount = self.contentSize.width / self.frame.size.width;
    if (page == 0) {
        [self setContentOffset:CGPointMake((pageCount-2)*self.frame.size.width, 0)];
    }
    if (page == pageCount-1) {
        [self setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
}

@end

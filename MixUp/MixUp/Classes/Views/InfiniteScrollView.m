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

    CGFloat xOffset = 0.0;
    CGFloat width   = self.frame.size.width;
    CGFloat height  = self.frame.size.height;
    
    UIImageView * imgView = [[[UIImageView alloc] initWithImage:[images lastObject]] autorelease];
    imgView.frame = CGRectMake(xOffset, 0.0, width, height);
    xOffset += width;
    [self addSubview:imgView];
    
    for (int i=0; i < [images count]; i++) {
        UIImageView * imgView = [[[UIImageView alloc] initWithImage:[images objectAtIndex:i]] autorelease];
        imgView.frame = CGRectMake(xOffset, 0.0, width, height);
        xOffset += width;
        [self addSubview:imgView];
    }
    imgView = [[[UIImageView alloc] initWithImage:[images objectAtIndex:0]] autorelease];
    imgView.frame = CGRectMake(xOffset, 0.0, width, height);
    xOffset += width;
    [self addSubview:imgView];
    
    self.contentSize = CGSizeMake(xOffset, self.frame.size.height);
}

- (NSInteger)currentImageIndex {
    return self.contentOffset.x / self.frame.size.width;
}

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(page*self.frame.size.width, 0) animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    int page = floor((self.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
    int pageCount = ceil(self.contentSize.width / self.frame.size.width);
    if (page == 0) {
        [self scrollRectToVisible:CGRectMake((pageCount-2)*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }
    if (page == pageCount-1) {
        [self scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }
}

@end

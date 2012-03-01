//
//  InfiniteScrollView.h
//  MixUp
//
//  Created by Vita on 2/28/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteScrollView : UIScrollView <UIScrollViewDelegate>
{

}

- (void)displayImages:(NSArray*)images;
- (NSInteger)currentImageIndex;

@end

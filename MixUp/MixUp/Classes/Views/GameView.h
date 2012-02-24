//
//  GameView.h
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Al Digit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView {
    UIScrollView * headsScrollView;
    UIScrollView * bodiesScrollView;
    UIScrollView * feetScrollView;
}

- (id)initWithImageNames:(NSArray*)imageNames;

@end

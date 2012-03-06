//
//  AboutView.h
//  MixUp
//
//  Created by Vita on 3/6/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AbsractView.h"

@class AboutView;

@protocol AboutViewProtocol <NSObject>

@optional
- (void)aboutViewBackButtonPressed:(AboutView*)gameView;

@end

@interface AboutView : UIView

@property (nonatomic, assign)id<AboutViewProtocol> delegate;

@end

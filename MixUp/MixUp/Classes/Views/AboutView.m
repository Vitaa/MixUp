//
//  AboutView.m
//  MixUp
//
//  Created by Vita on 3/6/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

@synthesize delegate;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UIWebView * about = [[[UIWebView alloc] initWithFrame:frame] autorelease];
        about.delegate = self;
        about.autoresizesSubviews = YES;
        about.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [about loadHTMLString:[NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"about" withExtension:@"html"] encoding:NSUTF8StringEncoding error:nil] 
                      baseURL:[[NSBundle mainBundle] bundleURL]];
        [self addSubview:about];
    
    }
    return self;
}

- (void)onBack:(id)sender {
    if ([delegate respondsToSelector:@selector(aboutViewBackButtonPressed:)])
        [delegate aboutViewBackButtonPressed:self];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}

@end

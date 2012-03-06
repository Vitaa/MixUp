//
//  AboutViewController.m
//  MixUp
//
//  Created by Vita on 3/6/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    AboutView * view = [[[AboutView alloc] init] autorelease];
    view.delegate = self;
    self.view = view;
    
    self.navigationController.navigationBarHidden = NO;
    self.title = NSLocalizedString(@"О нас", @"");
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - about view delegate

- (void)aboutViewBackButtonPressed:(AboutView *)gameView {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

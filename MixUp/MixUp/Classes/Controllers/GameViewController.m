//
//  GameViewController.m
//  MixUp
//
//  Created by Vita on 2/24/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "GameViewController.h"
#import "AudioManager.h"
#import "GameState.h"

@implementation GameViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    GameView * view = [[[GameView alloc] init] autorelease];
    view.delegate = self;
    self.view = view;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [(GameView*)self.view initialize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - game view delegate
- (void)gameView:(GameView *)gameView whoAmIPressedWithAnimalsState:(GameState *)animals {
    [[AudioManager sharedManager] playSoundsForAnimalWithState:animals];
}

- (void)gameViewBackButtonPressed:(GameView *)gameView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - shake

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [(GameView*)self.view shuffleAnimated:YES];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

@end

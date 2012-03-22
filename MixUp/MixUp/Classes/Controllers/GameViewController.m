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
#import "UIAlertView+Block.h"

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
#ifdef LITE
    gamesPlayed = 0;
#endif
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
    
#ifdef LITE
    gamesPlayed++;
    
    if (gamesPlayed > 10) {
        if (arc4random() % 10 >= 8) {
            [[UIAlertView alertViewWithTitle:NSLocalizedString(@"Больше картинок в полной версии. Купить?", @"") 
                                     message:@"" 
                           cancelButtonTitle:NSLocalizedString(@"Нет", @"") 
                           otherButtonTitles:[NSArray arrayWithObject:NSLocalizedString(@"Да", @"")] 
                                   onDismiss:^(int buttonIndex) {
                                       if (buttonIndex == 0) {
                                           // open full version url
                                           NSLog(@"buy");
                                       }
                                   }
                                    onCancel:^() {
                                    }] 
             show];
        }
    }
#endif
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

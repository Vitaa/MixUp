//
//  PuzzleViewController.m
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "PuzzleViewController.h"
#import "AudioManager.h"

@interface PuzzleViewController()
- (void)startNewLevel;
- (void)loseWithOutOfTime:(BOOL)outOfTime;
@end

@implementation PuzzleViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    PuzzleView * view = [[[PuzzleView alloc] init] autorelease];
    view.delegate = self;
    self.view = view;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [(PuzzleView*)self.view initSuffle];
    
    currentLevel = 1;
    [self startNewLevel];
}

#pragma mark - puzzle view delegate
- (void)puzzleViewBackButtonPressed:(PuzzleView *)gameView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)puzzleView:(PuzzleView *)gameView checkPressedWithAnimalsState:(GameState *)animals {
    if ([currentPuzzle check:animals]) {
        [self startNewLevel];
    }
    else {
        [self loseWithOutOfTime:NO];
    }
}

#pragma mark - private
- (void)startNewLevel {
    if (currentPuzzle == nil) {
        currentPuzzle = [[Puzzle alloc] initWithLevel:currentLevel];
        [[AudioManager sharedManager] playPuzzleSoundsFromAnimalWithState:[currentPuzzle gameState]];
    }
    else {
        [currentPuzzle release];
        currentLevel = arc4random() % 3 + 1;
        currentPuzzle = [[Puzzle alloc] initWithLevel:currentLevel];
        [[AudioManager sharedManager] playNextPuzzleSoundsFromAnimalWithState:[currentPuzzle gameState]];
    }
}

- (void)loseWithOutOfTime:(BOOL)outOfTime {
    if(outOfTime) {
//        mTimer.cancel();
//        mCurrentLevel = 0;
//        mCurrentPuzzle = null;
//        mSoundManager.playTimeoutSound(this);
//        AlertDialog dialog = new AlertDialog.Builder(this).create();
//        dialog.setMessage("Время истекло");
//        dialog.setButton("Еще раз", this);
//        dialog.setButton2("Закончить", this);
//        dialog.show();
    } else {
        [[AudioManager sharedManager] playNotCorrectSound:[currentPuzzle gameState]];
    }

}

@end

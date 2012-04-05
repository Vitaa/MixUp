//
//  PuzzleViewController.m
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "PuzzleViewController.h"
#import "AudioManager.h"
#import "NSDate+Time.h"
#import "UIAlertView+Block.h"

@interface PuzzleViewController()
- (void)startNewLevel;
- (void)loseWithOutOfTime:(BOOL)outOfTime;
@end

@implementation PuzzleViewController

#define kLevelsCount 9

static int levels[kLevelsCount][2] = {
    { 300, 1 },
    { 250, 1 },
    { 200, 1 },
    { 150, 2 },
    { 100, 2 },
    {  50, 2 },
    {  30, 3 },
    {  20, 3 },
    {  10, 3 }
};

- (id) init {
    if ((self=[super init])) {
    }
    return self;
}

- (void)dealloc {
  
    [currentPuzzle release];
    [super dealloc];
}

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
    [view initShuffle];
    self.view = view;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)onTimer:(NSTimer*)timer{
    
    NSInteger levelSec = levels[currentLevel][0];
    NSInteger time = levelSec - ([[NSDate date] timeIntervalSince1970]-startTime);
    
    if (time < 0) {
        [self loseWithOutOfTime:YES];
    }
    else {
        [(PuzzleView*)self.view setTime:[[NSDate dateWithTimeIntervalSince1970:time] timeString]];
        
        if (time <= 3.0) {
            [(PuzzleView*)self.view setTimeColor:[UIColor redColor]];
        }
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    currentLevel = 0;
    
    [self startNewLevel];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

#pragma mark - puzzle view delegate
- (void)puzzleViewBackButtonPressed:(PuzzleView *)gameView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)puzzleView:(PuzzleView *)gameView checkPressedWithAnimalsState:(GameState *)animals {
    if ([currentPuzzle check:animals]) {
        if (currentLevel+1 == kLevelsCount) {
            [[AudioManager sharedManager] playWinSound];
            
            [timer invalidate];
            timer = nil;
            
            currentLevel = 0;
            [currentPuzzle release];
            currentPuzzle = nil;
            
            [[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Вы победили!", @"") 
                                         message:@"" 
                                        delegate:self 
                               cancelButtonTitle:NSLocalizedString(@"Закончить", @"") 
                               otherButtonTitles:NSLocalizedString(@"Еще раз", @""), nil] autorelease] show];
        }  
        else {
#ifdef LITE
            if (currentLevel > 2) {   
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
            [self startNewLevel];
        }
    }
    else {
        [self loseWithOutOfTime:NO];
    }
}

#pragma mark - private
- (void)startNewLevel {
    if (currentPuzzle == nil) {
        currentPuzzle = [[Puzzle alloc] initWithLevel:levels[currentLevel][1]];
        [[AudioManager sharedManager] playPuzzleSoundsFromAnimalWithState:[currentPuzzle gameState]];
    }
    else {
        currentLevel++;
        Puzzle * nextPuzzle = [[Puzzle alloc] initWithLevel:levels[currentLevel][1]];
        while ([currentPuzzle.gameState isEqual:nextPuzzle.gameState]) {
            [nextPuzzle release];
            nextPuzzle = [[Puzzle alloc] initWithLevel:levels[currentLevel][1]];
        }
        [currentPuzzle release];
        currentPuzzle = nextPuzzle;
        [[AudioManager sharedManager] playNextPuzzleSoundsFromAnimalWithState:[currentPuzzle gameState]];
    }
    startTime = [[NSDate date] timeIntervalSince1970];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [(PuzzleView*)self.view setTimeColor:[UIColor whiteColor]];
}

- (void)loseWithOutOfTime:(BOOL)outOfTime {
    if(outOfTime) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        currentLevel = 0;
        [currentPuzzle release];
        currentPuzzle = nil;
        [[AudioManager sharedManager] playTimeoutSound];

        [[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Время истекло", @"") 
                                   message:@"" 
                                  delegate:self 
                         cancelButtonTitle:NSLocalizedString(@"Закончить", @"") 
                         otherButtonTitles:NSLocalizedString(@"Еще раз", @""), nil] autorelease] show];
    } else {
        [[AudioManager sharedManager] playNotCorrectSound:[currentPuzzle gameState]];
    }
}

#pragma mark - alert view delegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self startNewLevel];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

//
//  MainViewController.m
//  MixUp
//
//  Created by Vita on 3/1/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "PuzzleViewController.h"
#import "AboutViewController.h"

@implementation MainViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    MainView * view = [[[MainView alloc] init] autorelease];
    view.delegate = self;
    self.view = view;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


#pragma mark - main view delegate
- (void)mainViewGuessButtonPressed:(MainView*)mainView {
    GameViewController * gameController = [[[GameViewController alloc] init] autorelease];
    [self.navigationController pushViewController:gameController animated:YES];
}

- (void)mainViewCombineButtonPressed:(MainView *)mainView {
    PuzzleViewController * puzzleController = [[[PuzzleViewController alloc] init] autorelease];
    [self.navigationController pushViewController:puzzleController animated:YES];

}

- (void)mainViewAboutButtonPressed:(MainView *)mainView {
    AboutViewController * aboutController = [[[AboutViewController alloc] init] autorelease];
    [self.navigationController pushViewController:aboutController animated:YES];
}

@end

//
//  PuzzleViewController.h
//  MixUp
//
//  Created by Vita on 3/2/12.
//  Copyright (c) 2012 Mix Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuzzleView.h"
#import "Puzzle.h"

@interface PuzzleViewController : UIViewController <PuzzleViewProtocol> {
    Puzzle * currentPuzzle;
    NSInteger currentLevel;
}
@end

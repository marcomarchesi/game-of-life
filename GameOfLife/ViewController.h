//
//  ViewController.h
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "game.h"
@class GameView;
@interface ViewController : UIViewController<UIGestureRecognizerDelegate>{
    
    int game_array[game::WORLD_SIZE][game::WORLD_SIZE];
    int next_array[game::WORLD_SIZE][game::WORLD_SIZE];
    int time;
    int game_state;
    NSTimer *game_timer;
}

@property IBOutlet GameView *gameView;
@property IBOutlet UIButton *startButton;
-(IBAction)start:(id)sender;
@end


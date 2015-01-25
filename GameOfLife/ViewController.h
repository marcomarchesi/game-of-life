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
    UITapGestureRecognizer *tapRecognizer;
    
    UIImageView *infoView;
    UIView *patternsView;
    int pattern;
}

@property IBOutlet GameView *gameView;
@property IBOutlet UIButton *startButton;
@property IBOutlet UIButton *infoButton;
@property IBOutlet UIButton *patternsButton;
-(IBAction)start:(id)sender;
-(IBAction)info:(id)sender;
-(IBAction)patterns:(id)sender;
-(void)resetWithPattern:(int)pattern;
@end


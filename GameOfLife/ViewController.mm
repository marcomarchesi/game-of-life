//
//  ViewController.m
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize gameView;
@synthesize startButton = _startButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    time = 0;
    game_state = 0;
    gameView.cell_size = gameView.frame.size.width/ game::WORLD_SIZE;
    
    NSLog(@"%i",gameView.cell_size);
    [self.view setNeedsDisplay];
    
    game::init(game_array);
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    
}
-(IBAction)start:(id)sender{
    
    NSLog(@"game state is %i",game_state);
    
    if(game_state == 0){
        game_state = 1;
        NSLog(@"Tap detected!");
        game_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(run)
                                       userInfo:nil
                                        repeats:YES];
    }else{
        game_state = 0;
        [game_timer invalidate];
        time = 0;
        [self.view setNeedsDisplay];
//        game::init(game_array);
//        
//        for(int i = 0;i<game::WORLD_SIZE;++i){
//            for(int j=0;j<game::WORLD_SIZE;++j){
//                [gameView update:i with:j andValue:game_array[i][j]];
//            }
//        }

    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.gameView];
    
    int i_value = (touchLocation.x / gameView.cell_size);
    int j_value = (touchLocation.y / gameView.cell_size);
    
    if(game_state == 0){
        game_array[i_value][j_value] = !game_array[i_value][j_value];
        [gameView update:i_value with:j_value andValue:game_array[i_value][j_value]];
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view setNeedsDisplay];
}

-(void)run{
    
        for(int i = 0;i<game::WORLD_SIZE;++i){
            for(int j=0;j<game::WORLD_SIZE;++j){
                next_array[i][j] = game::explore(game_array,i,j);
            }
        }
        
        for(int i = 0;i<game::WORLD_SIZE;++i){
            for(int j=0;j<game::WORLD_SIZE;++j){
                game_array[i][j] = next_array[i][j];
                [gameView update:i with:j andValue:game_array[i][j]];
            }
        }
    
        time++;    
};


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"
#import "BGView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize gameView;
@synthesize startButton = _startButton;
- (void)viewDidLoad {
    [super viewDidLoad];

    
    time = 0;
    game_state = 0; //game stop
    gameView.cell_size = gameView.frame.size.width/ game::WORLD_SIZE;
    
    
    // add a dark cells background
    // TODO more elegant solution
    BGView *bgView = [[BGView alloc]initWithFrame:gameView.frame];
    bgView.cell_size = gameView.cell_size;
    [self.view addSubview:bgView];
    
    
    //bring the gameView in front
    [self.view addSubview:gameView];

    
    [self.view setNeedsDisplay];
    
    
    // recognize double touch
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reset)];
    tapRecognizer.numberOfTouchesRequired = 2;
    [self.gameView addGestureRecognizer:tapRecognizer];
    
    // initialize the cells array
    game::init(game_array);
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    
}
/* START 
 button enabled
 */
-(IBAction)start:(id)sender{
    
    if(game_state == 0){    //start the game
        game_state = 1;
        game_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(run)
                                       userInfo:nil
                                        repeats:YES];
    }else{  //stop the game
        game_state = 0;
        [game_timer invalidate];
        

    }
}
/* RESET
 Activated by double touch
 */
-(void)reset{
    
    [game_timer invalidate];
    time = 0;
    game_state = 0;
    game::init(game_array);
    
    //reset all the cells
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    [self.view setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:gameView];
    
    int i_value = (touchLocation.x / gameView.cell_size);
    int j_value = (touchLocation.y / gameView.cell_size);

    if(j_value >-1 && j_value<game::WORLD_SIZE){    //otherwise it's out of range
            game_array[i_value][j_value] = !game_array[i_value][j_value];
            [gameView update:i_value with:j_value andValue:game_array[i_value][j_value]];
        [self.view setNeedsDisplay];
    }
    if(game_state == 1){    //stop the game if you add cells
        game_state = 0;
        [game_timer invalidate];
    }
    
}
/* RUN
 game progress using game::explore C++ method
 */
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

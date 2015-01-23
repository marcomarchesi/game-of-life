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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    time = 0;
    gameView.cell_size = gameView.frame.size.width/ game::WORLD_SIZE;
    
    NSLog(@"%i",gameView.cell_size);
    [self.view setNeedsDisplay];
    
    game::init(game_array);
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
   
    
    
}
-(void)start{
    
    NSLog(@"Tap detected!");
    
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(run)
                                   userInfo:nil
                                    repeats:YES];
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

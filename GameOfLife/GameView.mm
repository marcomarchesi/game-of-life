//
//  GameView.m
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import "GameView.h"
#import "game.h"

@implementation GameView
@synthesize cell_size = _cell_size;

-(void)update:(int)i_value with:(int)j_value andValue:(int)cell_value{
    
    game_array[i_value][j_value] = cell_value;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            
            CGContextSetRGBFillColor (myContext, 0,1,1, game_array[i][j]);
            CGContextFillRect (myContext, CGRectMake (i*_cell_size, j*_cell_size, _cell_size-1, _cell_size-1));
        }
    };
}

@end

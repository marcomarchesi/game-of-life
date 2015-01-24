//
//  BGView.m
//  GameOfLife
//
//  Created by Marco Marchesi on 1/24/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import "BGView.h"
#import "game.h"

@implementation BGView
@synthesize cell_size = _cell_size;
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            CGContextSetRGBFillColor (myContext, 0.05,0.05,0.05,1);
            CGContextFillRect (myContext, CGRectMake (i*_cell_size, j*_cell_size, _cell_size-1, _cell_size-1));
        }
    };
}

@end

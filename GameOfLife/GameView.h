//
//  GameView.h
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "game.h"
@interface GameView : UIView{
    int game_array[game::WORLD_SIZE][game::WORLD_SIZE];
}

@property int cell_size;

-(void)update:(int)i_value with:(int)j_value andValue:(int)cell_value;
@end

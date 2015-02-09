//
//  game.h
//  GameOfLife
//
//  Created by Marco Marchesi on 12/13/14.
//  Copyright (c) 2014 Marco Marchesi. All rights reserved.
//

#ifndef __GameOfLife__game__
#define __GameOfLife__game__

#include <stdio.h>

namespace game{
    
    // some constants
    static const int WORLD_SIZE = 40;   //number of cells in a row
    static const int DEAD = 0;
    static const int ALIVE = 1;
    static const int GAME_CYAN = 0;
    static const int GAME_YELLOW = 1;
    static const int GAME_GREEN = 2;
    // methods
    void init(int array[][WORLD_SIZE]);
    void initWithPattern(int array[][WORLD_SIZE],int pattern);
    int explore(int array[][WORLD_SIZE],int x, int y);
}

#endif /* defined(__GameOfLife__game__) */

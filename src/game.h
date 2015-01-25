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
    static const int WORLD_SIZE = 40;   //number of cells in a row
    static const int DEAD = 0;
    static const int ALIVE = 1;
    void init(int array[][WORLD_SIZE]);
    void initWithPattern(int array[][WORLD_SIZE],int pattern);
    int explore(int array[][WORLD_SIZE],int x, int y);
}

#endif /* defined(__GameOfLife__game__) */

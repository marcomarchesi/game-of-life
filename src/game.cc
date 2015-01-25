//
//  game.cc
//  GameOfLife
//
//  Created by Marco Marchesi on 12/13/14.
//  Copyright (c) 2014 Marco Marchesi. All rights reserved.
//

#include "game.h"
#include <iostream>
namespace game{
    
    // init all the cells to DEAD value
    void init(int array[][WORLD_SIZE]){
        for(int i = 0;i<WORLD_SIZE;++i){
            for(int j=0;j<WORLD_SIZE;++j){
                array[i][j] = DEAD;
            }
        }
// uncomment for default cells
        array[3][39] = ALIVE;
        array[4][39] = ALIVE;
        array[5][39] = ALIVE;
        array[4][38] = ALIVE;
    }
    
    //check cell's neighbors
    int explore(int array[][WORLD_SIZE],int x, int y){
        
        int live_counter = 0;
        
        if(x>0 && y>0)
            if(array[x-1][y-1] == ALIVE){
                live_counter++;
            }
        if(x>0)
            if(array[x-1][y] == ALIVE){
                live_counter++;
            }
        if(x>0 && y<WORLD_SIZE-1)
            if(array[x-1][y+1] == ALIVE){
                live_counter++;
            }
        if(y>0)
            if(array[x][y-1] == ALIVE){
                live_counter++;
            }
        if(y>0 && x<WORLD_SIZE-1)
            if(array[x+1][y-1] == ALIVE){
                live_counter++;
            }
        if(x<WORLD_SIZE-1)
            if(array[x+1][y] == ALIVE){
                live_counter++;
            }
        if(y<WORLD_SIZE-1)
            if(array[x][y+1] == ALIVE){
                live_counter++;
            }
        if(x<WORLD_SIZE-1 && y<WORLD_SIZE-1)
            if(array[x+1][y+1] == ALIVE){
                live_counter++;
            }

        
        //Conways'Game of Life rules
        if(array[x][y] == ALIVE){   //cell is alive
            if(live_counter>1 && live_counter<4)
                return ALIVE;
            else
                return DEAD;
        }else{  //cell is dead
            if(live_counter==3)
                return ALIVE;
            else
                return DEAD;
        }
        return DEAD;
    }
    
}

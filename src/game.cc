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
    
    void init(int array[][WORLD_SIZE]){
        for(int i = 0;i<WORLD_SIZE;++i){
            for(int j=0;j<WORLD_SIZE;++j){
                array[i][j] = DEAD;
            }
        }
//        array[2][3] = ALIVE;
//        array[1][4] = ALIVE;
//        array[3][3] = ALIVE;
//        array[3][2] = ALIVE;
    }
        
    int explore(int array[][WORLD_SIZE],int x, int y){
        
        int live_counter = 0;
        
        int a = x+1;
        int b = y+1;

        if(array[x-1][y-1] == ALIVE)
            live_counter++;
        if(array[x-1][y] == ALIVE)
            live_counter++;
        
        if(b<WORLD_SIZE)
            if(array[x-1][y+1] == ALIVE)
                live_counter++;
        if(array[x][y-1] == ALIVE)
            live_counter++;
        
        if(a<WORLD_SIZE)
            if(array[x+1][y-1] == ALIVE)
                live_counter++;
        if(a<WORLD_SIZE)
            if(array[x+1][y] == ALIVE)
                live_counter++;
        
        if(b<WORLD_SIZE)
            if(array[x][y+1] == ALIVE)
                live_counter++;
        
        if(a<WORLD_SIZE && b<WORLD_SIZE){
            if(array[x+1][y+1] == ALIVE)
                live_counter++;
        }
        
        
        if(array[x][y] == ALIVE){   //cell is alive
            if(live_counter>1 && live_counter<4)
                return ALIVE;
            else
                return DEAD;
        }else{  //cell is dead
            if(live_counter>2)
                return ALIVE;
            else
                return DEAD;
        }
        return 0;
    }
    
}

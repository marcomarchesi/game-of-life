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
    }
    
    void initWithPattern(int array[][WORLD_SIZE],int pattern){
        
        for(int i = 0;i<WORLD_SIZE;++i){
            for(int j=0;j<WORLD_SIZE;++j){
                array[i][j] = DEAD;
            }
        }
        
        switch (pattern) {
            case 1: //spaceship
            {
                array[8][25] = ALIVE;
                array[9][25] = ALIVE;
                array[6][26] = ALIVE;
                array[7][26] = ALIVE;
                array[9][26] = ALIVE;
                array[10][26] = ALIVE;
                array[6][27] = ALIVE;
                array[7][27] = ALIVE;
                array[8][27] = ALIVE;
                array[9][27] = ALIVE;
                array[7][28] = ALIVE;
                array[8][28] = ALIVE;
                
            }
                break;
            case 2: //glider
            {
                array[30][30] = ALIVE;
                array[31][30] = ALIVE;
                array[29][31] = ALIVE;
                array[30][31] = ALIVE;
                array[31][32] = ALIVE;
            }
                break;
            case 3: //gopher glider gun - infinite
            {
                array[2][6] = ALIVE;
                array[3][6] = ALIVE;
                array[2][7] = ALIVE;
                array[3][7] = ALIVE;
                array[12][6] = ALIVE;
                array[12][7] = ALIVE;
                array[12][8] = ALIVE;
                array[13][5] = ALIVE;
                array[13][9] = ALIVE;
                array[14][4] = ALIVE;
                array[14][10] = ALIVE;
                array[15][4] = ALIVE;
                array[15][10] = ALIVE;
                array[16][7] = ALIVE;
                array[17][5] = ALIVE;
                array[17][9] = ALIVE;
                array[18][6] = ALIVE;
                array[18][7] = ALIVE;
                array[18][8] = ALIVE;
                array[19][7] = ALIVE;
                array[22][4] = ALIVE;
                array[22][5] = ALIVE;
                array[22][6] = ALIVE;
                array[23][4] = ALIVE;
                array[23][5] = ALIVE;
                array[23][6] = ALIVE;
                array[24][3] = ALIVE;
                array[24][7] = ALIVE;
                array[26][3] = ALIVE;
                array[26][7] = ALIVE;
                array[26][2] = ALIVE;
                array[26][8] = ALIVE;
                array[36][4] = ALIVE;
                array[37][4] = ALIVE;
                array[36][5] = ALIVE;
                array[37][5] = ALIVE;
            }
                break;
            default:
                break;
        }
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

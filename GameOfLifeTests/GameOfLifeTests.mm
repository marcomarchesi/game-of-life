//
//  GameOfLifeTests.m
//  GameOfLifeTests
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "game.h"

@interface GameOfLifeTests : XCTestCase{
    int game_array[game::WORLD_SIZE][game::WORLD_SIZE];
    int next_array[game::WORLD_SIZE][game::WORLD_SIZE];
}
@end

@implementation GameOfLifeTests

- (void)setUp {
    [super setUp];
    
    // initialize the cells array
    game::init(game_array);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExplore {
    //Check if the cell (5,0) is DEAD (0)
    int value = game::explore(game_array,5,0);
    XCTAssertEqual(value,0,@"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

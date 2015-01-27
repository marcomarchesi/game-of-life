//
//  ViewController.m
//  GameOfLife
//
//  Created by Marco Marchesi on 1/23/15.
//  Copyright (c) 2015 Marco Marchesi. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"
#import "BGView.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate>

@property (strong,nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@property (strong, nonatomic) AVAudioPlayer *cellSoundPlayer;
@property (strong, nonatomic) AVAudioPlayer *resetSoundPlayer;

@end

@implementation ViewController
@synthesize gameView;
@synthesize startButton = _startButton;
@synthesize infoButton = _infoButton;
@synthesize patternsButton = _patternsButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //configure sounds
    [self configureMusicAndSound];
    
   
    
    //begin with values
    pattern = 0;
    time = 0;
    color = 0;
    game_state = 0; //game stop
    gameView.cell_size = gameView.frame.size.width/ game::WORLD_SIZE;
    gameView.r = 0;
    gameView.g = 1;
    gameView.b = 1;
    
    
    // add a dark cells background
    // TODO more elegant solution
    BGView *bgView = [[BGView alloc]initWithFrame:gameView.frame];
    bgView.cell_size = gameView.cell_size;
    [self.view addSubview:bgView];
    
    
    //bring the gameView in front
    [self.view addSubview:gameView];
    
    //add info image
    infoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"info.png"]];
    [gameView addSubview:infoView];
    infoView.hidden = YES;
    
    //add patterns buttons
    patternsView = [[UIView alloc]initWithFrame:CGRectMake(0, 154,self.view.frame.size.width, 300)];
    patternsView.backgroundColor = [UIColor blackColor];
    [gameView addSubview:patternsView];
    patternsView.hidden = YES;
    
    UIButton *pattern_one_button = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 256, 256)];
    [pattern_one_button setImage:[UIImage imageNamed:@"pattern-spaceship-button.png"] forState:UIControlStateNormal];
    [pattern_one_button addTarget:self action:@selector(selectSpaceShip) forControlEvents:UIControlEventTouchUpInside];
    [patternsView addSubview:pattern_one_button];
    UIButton *pattern_two_button = [[UIButton alloc]initWithFrame:CGRectMake(250, 20, 256, 256)];
    [pattern_two_button setImage:[UIImage imageNamed:@"pattern-glider-button.png"] forState:UIControlStateNormal];
    [pattern_two_button addTarget:self action:@selector(selectGlider) forControlEvents:UIControlEventTouchUpInside];
    [patternsView addSubview:pattern_two_button];
    UIButton *pattern_three_button = [[UIButton alloc]initWithFrame:CGRectMake(500, 20, 256, 256)];
    [pattern_three_button setImage:[UIImage imageNamed:@"pattern-glidergun-button.png"] forState:UIControlStateNormal];
    [pattern_three_button addTarget:self action:@selector(selectGliderGun) forControlEvents:UIControlEventTouchUpInside];
    [patternsView addSubview:pattern_three_button];
    
    [self.view setNeedsDisplay];
    
    
    // recognize double touch
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reset)];
    tapRecognizer.numberOfTouchesRequired = 2;
    [self.gameView addGestureRecognizer:tapRecognizer];
    
    // initialize the cells array
    game::initWithPattern(game_array, 1);
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    
}

-(void)configureMusicAndSound{
    
    // Create audio player for background
    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"gameoflife" ofType:@"caf"];
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
    self.backgroundMusicPlayer.delegate = self;
    self.backgroundMusicPlayer.volume = 0.3;
    self.backgroundMusicPlayer.numberOfLoops = -1;	//no loops
    [self.backgroundMusicPlayer play];
    
    // Create audio player for cell sound
    NSString *cellSoundPath = [[NSBundle mainBundle] pathForResource:@"cell" ofType:@"caf"];
    NSURL *cellSoundURL = [NSURL fileURLWithPath:cellSoundPath];
    self.cellSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:cellSoundURL error:nil];
    self.cellSoundPlayer.delegate = self;
    self.cellSoundPlayer.volume = 0.5;
    self.cellSoundPlayer.numberOfLoops = 0;	//no loops
    // Create audio player for cell sound
    NSString *resetSoundPath = [[NSBundle mainBundle] pathForResource:@"reset" ofType:@"caf"];
    NSURL *resetSoundURL = [NSURL fileURLWithPath:resetSoundPath];
    self.resetSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:resetSoundURL error:nil];
    self.resetSoundPlayer.delegate = self;
    self.resetSoundPlayer.volume = 0.3;
    self.resetSoundPlayer.numberOfLoops = 0;	//no loops
}


/* START 
 button enabled
 */
-(IBAction)start:(id)sender{
    
    if(![patternsView isHidden])
        [patternsView setHidden:YES];
    if(![infoView isHidden])
        [infoView setHidden:YES];
    
    if(game_state == 0){    //start the game
        game_state = 1;
        game_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(run)
                                       userInfo:nil
                                        repeats:YES];
    }else{  //stop the game
        game_state = 0;
        [game_timer invalidate];
    }
}
-(void)restart{
    game_state = 1;
    game_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(run)
                                                userInfo:nil
                                                 repeats:YES];
}
/* INFO
 get info
 */

-(IBAction)info:(id)sender{
    
    if(![patternsView isHidden])
        [patternsView setHidden:YES];
    
    if ([infoView isHidden])
        [infoView setHidden:NO];
    else
        [infoView setHidden:YES];
}
/* PATTERNS
 show patterns
 */
-(IBAction)patterns:(id)sender{
    
    if(![infoView isHidden])
        [infoView setHidden:YES];
    
    if([patternsView isHidden])
        [patternsView setHidden:NO];
    else
        [patternsView setHidden:YES];
    
}
-(IBAction)options:(id)sender{
    
    switch (color) {
        case 0:
        {
            [self selectYellow];
            color = 1;
        }
            break;
        case 1:
        {
            [self selectGreen];
            color = 2;
        }
            break;
        case 2:
        {
            [self selectCyan];
            color = 0;
        }
            break;
        default:
            break;
    }
    
    if(![patternsView isHidden])
        [patternsView setHidden:YES];
    if(![infoView isHidden])
        [infoView setHidden:YES];
}


-(void)selectSpaceShip{
    [self resetWithPattern:1];
}
-(void)selectGlider{
    [self resetWithPattern:2];
}
-(void)selectGliderGun{
    [self resetWithPattern:3];
}

-(void)selectCyan{
    gameView.r = 0;
    gameView.g = 1;
    gameView.b = 1;
    [_startButton setImage:[UIImage imageNamed:@"startButtonCyan.png"] forState:UIControlStateNormal];
    [gameView setNeedsDisplay];
}
-(void)selectYellow{
    gameView.r = 1;
    gameView.g = 1;
    gameView.b = 0;
    [_startButton setImage:[UIImage imageNamed:@"startButtonYellow.png"] forState:UIControlStateNormal];
    [gameView setNeedsDisplay];
}
-(void)selectGreen{
    gameView.r = 0;
    gameView.g = 1;
    gameView.b = 0;
    [_startButton setImage:[UIImage imageNamed:@"startButtonGreen.png"] forState:UIControlStateNormal];
    [gameView setNeedsDisplay];
}

-(void)resetWithPattern:(int)selected_pattern{
    
    [game_timer invalidate];
    time = 0;
    game_state = 0;
    
    // initialize the cells array
    game::initWithPattern(game_array,selected_pattern);
    
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    
    [patternsView setHidden:YES];
    [self.view setNeedsDisplay];
}


/* RESET
 Activated by double touch
 */
-(void)reset{
    
    [game_timer invalidate];
    time = 0;
    game_state = 0;
    game::init(game_array);
    
    //reset all the cells
    for(int i = 0;i<game::WORLD_SIZE;++i){
        for(int j=0;j<game::WORLD_SIZE;++j){
            [gameView update:i with:j andValue:game_array[i][j]];
        }
    }
    [self playResetSound];
    [self.view setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:gameView];
    
    int i_value = (touchLocation.x / gameView.cell_size);
    int j_value = (touchLocation.y / gameView.cell_size);
    
    if(j_value >-1 && j_value<game::WORLD_SIZE){    //otherwise it's out of range
        
        if(game_array[i_value][j_value] == game::DEAD){
            game_array[i_value][j_value] = game::ALIVE;
            [self playCellSound];
        }else{
            game_array[i_value][j_value] = game::DEAD;
        }
        
        
        if(game_state == 1){    //stop the game if you add cells
            game_state = 0;
            [game_timer invalidate];
            [self performSelector:@selector(restart) withObject:nil afterDelay:2.0];
        }
        
        [gameView update:i_value with:j_value andValue:game_array[i_value][j_value]];
        [self.view setNeedsDisplay];
    }
    

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:gameView];
    
    int i_value = (touchLocation.x / gameView.cell_size);
    int j_value = (touchLocation.y / gameView.cell_size);
    
    if(j_value >-1 && j_value<game::WORLD_SIZE){    //otherwise it's out of range
        
        if(game_array[i_value][j_value] == game::DEAD){
            game_array[i_value][j_value] = game::ALIVE;
            [self playCellSound];
        }

        [gameView update:i_value with:j_value andValue:game_array[i_value][j_value]];
        [self.view setNeedsDisplay];
    }
    if(game_state == 1){    //stop the game if you add cells
        game_state = 0;
        [game_timer invalidate];
    }

}

/* RUN
 game progress using game::explore C++ method
 */
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



-(void)playCellSound{
//    [self.cellSoundPlayer stop];
    [self.cellSoundPlayer play];
}
-(void)playResetSound{
    [self.resetSoundPlayer play];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

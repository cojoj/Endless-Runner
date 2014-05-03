//
//  Player.h
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode

@property (assign) BOOL selected;
@property (assign) BOOL accelerating;
@property (nonatomic, strong) NSMutableArray *runFrames;
@property (nonatomic, strong) NSMutableArray *jumpFrames;
@property (nonatomic, assign) playerState animationState;
@property (nonatomic, strong) NSMutableArray *shieldOnFrames;
@property (nonatomic, strong) NSMutableArray *shieldOffFrames;
@property (nonatomic, strong) SKSpriteNode *shield;
@property (assign, nonatomic) BOOL shielded;

@end

//
//  Player.h
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL accelerating;
@property (strong, nonatomic) NSMutableArray *runFrames;
@property (strong, nonatomic) NSMutableArray *jumpFrames;
@property (strong, nonatomic) NSMutableArray *shieldOnFrames;
@property (strong, nonatomic) NSMutableArray *shieldOffFrames;
@property (assign, nonatomic) int animationState;
@property (strong, nonatomic) SKSpriteNode *shield;
@property (assign, nonatomic) BOOL shielded;
@property (strong, nonatomic) SKEmitterNode *engineEmitter;

- (void) takeDamage;

@end

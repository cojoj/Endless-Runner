//
//  Enemy.m
//  Endless Runner
//
//  Created by Mateusz Zając on 04.05.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"enemy" ofType:@"sks"]];
    self.emitter.name = @"enemyEmitter";
    self.emitter.zPosition = 50;
    [self addChild:self.emitter];
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
    self.physicsBody.contactTestBitMask = playerBitmask;
    self.physicsBody.categoryBitMask = enemyBitmask;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.affectedByGravity = NO;
}

@end

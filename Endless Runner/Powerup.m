//
//  Powerup.m
//  Endless Runner
//
//  Created by Mateusz Zając on 04.05.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "Powerup.h"

@implementation Powerup

- (void)setup
{
    self.emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"powerup" ofType:@"sks"]];
    self.emitter.name = @"shieldEmitter";
    self.emitter.zPosition = 50;
    [self addChild:self.emitter];
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    self.physicsBody.contactTestBitMask = playerBitmask;
    self.physicsBody.categoryBitMask = shieldPowerupBitmask;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.affectedByGravity = NO;
}

@end

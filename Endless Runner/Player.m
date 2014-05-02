//
//  Player.m
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)init
{
    self = [super initWithImageNamed:@"character.png"];
    {
        self.name = playerName;
        self.zPosition = 10.0;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.physicsBody.mass = playerMass;
        self.physicsBody.collisionBitMask = playerCollisionBitmask;
        self.physicsBody.allowsRotation = NO;
    }
    return self;
}

@end

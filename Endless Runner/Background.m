//
//  Background.m
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "Background.h"

@implementation Background

+ (Background *)generateNewBackground
{
    Background *background = [[Background alloc] initWithImageNamed:@"background.png"];
    background.anchorPoint = CGPointMake(0, 0);
    background.name = backgroundName;
    background.zPosition = 5;
    background.position = CGPointMake(0, 0);
    background.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 30) toPoint:CGPointMake(background.size.width, 30)];
    background.physicsBody.collisionBitMask = playerCollisionBitmask;
    
    SKNode *topCollider = [SKNode node];
    topCollider.position = CGPointMake(0, 0);
    topCollider.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, background.size.height - 30)
                                                           toPoint:CGPointMake(background.size.width, background.size.height - 30)];
    topCollider.physicsBody.collisionBitMask = 1;
    [background addChild:topCollider];
    
    return background;
}

+ (Background *)generateNewParallax
{
    Background *background = [[Background alloc] initWithImageNamed:@"parallax.png"];
    background.anchorPoint = CGPointMake(0, 0);
    background.name = parallaxName;
    background.position = CGPointMake(0, 0);
    background.zPosition = 4;
    return background;
}

@end

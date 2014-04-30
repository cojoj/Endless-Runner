//
//  MyScene.m
//  Endless Runner
//
//  Created by Mateusz Zając on 29.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "MyScene.h"
#import "Player.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.currentBackground = [Background generateNewBackground];
        [self addChild:self.currentBackground];
        Player *player = [[Player alloc] init];
        player.position = CGPointMake(100, 68);
        [self addChild:player];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Animations for move up and down
    SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 100) duration:0.8];
    SKAction *moveDown = [SKAction moveBy:CGVectorMake(0, -100) duration:0.8];
    
    SKAction *seq = [SKAction sequence:@[moveUp, moveDown]];
    
    Player *player = (Player *)[self childNodeWithName:playerName];
    [player runAction:seq];
}

-(void)update:(CFTimeInterval)currentTime
{
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateInterval;
    self.lastUpdateInterval = currentTime;
    if (timeSinceLast > 1) {
        // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
    }
    
    [self enumerateChildNodesWithName:backgroundName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x - backgroundMoveSpeed * timeSinceLast, node.position.y);
    }];
}

@end

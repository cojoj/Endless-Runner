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
        
        self.score = 0;
        self.scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        self.scoreLabel.fontSize = 15;
        self.scoreLabel.color = [UIColor whiteColor];
        self.scoreLabel.position = CGPointMake(20, 300);
        self.scoreLabel.zPosition = 100;
        [self addChild:self.scoreLabel];
        
        SKAction *tempAction = [SKAction runBlock:^{
            self.scoreLabel.text = [NSString stringWithFormat:@"%3.0f", self.score];
        }];
        
        SKAction *waitAction = [SKAction waitForDuration:0.2];
        [self.scoreLabel runAction:[SKAction repeatActionForever:[SKAction sequence:@[tempAction, waitAction]]]];
        
        self.manager = [[CMMotionManager alloc] init];
        self.manager.accelerometerUpdateInterval = 0.1;
        [self.manager startAccelerometerUpdates];
        [self performSelector:@selector(adjustBaseline) withObject:nil afterDelay:0.1];
        
        self.physicsWorld.gravity = CGVectorMake(0, globalGravity);
    }
    return self;
}

- (void)adjustBaseline
{
    self.baseline = self.manager.accelerometerData.acceleration.x;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:[touch locationInNode:self]];
//    
//    if (touchedNode.name == playerName) {
//        Player *player = (Player *)touchedNode;
//        player.selected = YES;
//        return;
//    }
//    
//    // Animations for move up and down
//    SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 100) duration:0.8];
//    SKAction *moveDown = [SKAction moveBy:CGVectorMake(0, -100) duration:0.8];
//    
//    SKAction *seq = [SKAction sequence:@[moveUp, moveDown]];
//    
//    Player *player = (Player *)[self childNodeWithName:playerName];
//    [player runAction:seq];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    
//    Player *player = (Player *)[self childNodeWithName:playerName];
//    if (player.selected) {
//        player.position = [touch locationInNode:self];
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    Player *player = (Player *)[self childNodeWithName:playerName];
//    if (player.selected) {
//        player.selected = NO;
//    }
//}

- (void)didMoveToView:(SKView *)view
{
//    UILongPressGestureRecognizer *tapper = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
//    tapper.minimumPressDuration = 0.1;
//    [view addGestureRecognizer:tapper];
}

- (void)tappedScreen:(UITapGestureRecognizer *)recognizer
{
    Player *player = (Player *)[self childNodeWithName:@"player"];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        player.accelerating = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        player.accelerating = NO;
    }
}

- (void)handleSwipeGestureRight:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        backgroundMoveSpeed += 50;
    }
}

- (void)handleSwipeGestureLeft:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized && backgroundMoveSpeed > 50) {
        backgroundMoveSpeed -= 50;
    }
}

- (void)willMoveFromView:(SKView *)view
{
    for (UIGestureRecognizer *recognizer in view.gestureRecognizers) {
        [view removeGestureRecognizer:recognizer];
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateInterval;
    self.lastUpdateInterval = currentTime;
    
    if (timeSinceLast > 1) {
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateInterval = currentTime;
    }
    
    [self enumerateChildNodesWithName:backgroundName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x - backgroundMoveSpeed * timeSinceLast, node.position.y);
        
        if (node.position.x < - (node.frame.size.width + 100)) {
            [node removeFromParent];
        }
    }];
    
    if (self.currentBackground.position.x < -500) {
        Background *temp = [Background generateNewBackground];
        temp.position = CGPointMake(self.currentBackground.position.x + self.currentBackground.frame.size.width, 0);
        [self addChild:temp];
        self.currentBackground = temp;
    }
    
    self.score = self.score + (backgroundMoveSpeed * timeSinceLast / 100);
    // NSLog(@"%@", self.manager.accelerometerData);
    
    Player *player = (Player *)[self childNodeWithName:playerName];
    player.position = CGPointMake(player.position.x,
                                  player.position.y - (self.manager.accelerometerData.acceleration.x - self.baseline) * accelerometerMultiplier);
    if (player.position.y < 68) {
        player.position = CGPointMake(player.position.x, 68);
    }
    
    if (player.position.y > 252) {
        player.position = CGPointMake(player.position.x, 252);
    }
    
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *node, BOOL *stop) {
        Player *player = (Player *)node;
        if (player.accelerating) {
            [player.physicsBody applyForce:CGVectorMake(0, playerJumpForce * timeSinceLast)];
        }
    }];
}

@end

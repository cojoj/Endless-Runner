//
//  MyScene.m
//  Endless Runner
//
//  Created by Mateusz Zając on 29.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "MyScene.h"
#import "Player.h"
#import "Enemy.h"
#import "Powerup.h"
#import "GameOverScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.currentBackground = [Background generateNewBackground];
        [self addChild:self.currentBackground];
        
        self.currentParallax = [Background generateNewParallax];
        [self addChild:self.currentParallax];
        
        Player *player = [[Player alloc] init];
        player.position = CGPointMake(100, 68);
        [self addChild:player];
        self.player = player;
        
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
        
        self.physicsWorld.gravity = CGVectorMake(0, globalGravity);
        self.physicsWorld.contactDelegate = self;
        
        for (int i = 0; i < maximumEnemies; i++) {
            [self addChild:[self spawnEnemy]];
        }
        
        for (int i = 0; i < maximumPowerups; i++) {
            [self addChild:[self spawnPowerup]];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:@"playerDied" object:nil];
        
        
        // The application will crash here if your are testing on simulator or if bluetooth is turned off on device
        //[self configureGameControllers];
        
        self.pauseLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        self.pauseLabel.fontSize = 55;
        self.pauseLabel.color = [UIColor whiteColor];
        self.pauseLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        self.pauseLabel.zPosition = 110;
        [self addChild:self.pauseLabel];
        self.pauseLabel.text = @"Pause";
        self.pauseLabel.hidden = YES;
        
    }
    return self;
}


- (void) gameOver
{
    GameOverScene *newScene = [[GameOverScene alloc] initWithSize:self.size];
    SKTransition *transition = [SKTransition flipHorizontalWithDuration:0.5];
    [self.view presentScene:newScene transition:transition];
}

- (void) adjustBaseline
{
    self.baseline = self.manager.accelerometerData.acceleration.x;
}

- (void) didMoveToView:(SKView *)view
{
    self.tapper = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    self.tapper.minimumPressDuration = 0.1;
    [view addGestureRecognizer:self.tapper];
}

-(void)willMoveFromView:(SKView *)view
{
    [view removeGestureRecognizer:self.tapper];
}

- (void) tappedScreen:(UITapGestureRecognizer *)recognizer
{
    Player *player = (Player *)[self childNodeWithName:@"player"];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        player.accelerating = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        player.accelerating = NO;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    if (self.paused) {
        return;
    }
    
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    [self enumerateChildNodesWithName:backgroundName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x - backgroundMoveSpeed * timeSinceLast, node.position.y);
        if (node.position.x < - (node.frame.size.width + 100)) {
            // if the node went completely off screen (with some extra pixels)
            // remove it
            [node removeFromParent];
        }}];
    if (self.currentBackground.position.x < -500) {
        // we create new background node and set it as current node
        Background *temp = [Background generateNewBackground];
        temp.position = CGPointMake(self.currentBackground.position.x + self.currentBackground.frame.size.width, 0);
        [self addChild:temp];
        self.currentBackground = temp;
    }
    
    [self enumerateChildNodesWithName:parallaxName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x - parallaxMoveSpeed * timeSinceLast, node.position.y);
        if (node.position.x < - (node.frame.size.width + 100)) {
            // if the node went completely off screen (with some extra pixels)
            // remove it
            [node removeFromParent];
        }}];
    if (self.currentParallax.position.x < -500) {
        // we create new background node and set it as current node
        Background *temp = [Background generateNewParallax];
        temp.position = CGPointMake(self.currentParallax.position.x + self.currentParallax.frame.size.width, 0);
        [self addChild:temp];
        self.currentParallax = temp;
    }
    
    self.score = self.score + (backgroundMoveSpeed * timeSinceLast / 100);
    
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *node, BOOL *stop) {
        Player *player = (Player *)node;
        if (player.accelerating) {
            [player.physicsBody applyForce:CGVectorMake(0, playerJumpForce * timeSinceLast)];
            player.animationState = playerStateJumping;
        } else if (player.position.y < 75) {
            player.animationState = playerStateRunning;
        }
    }];
    
    [self enumerateChildNodesWithName:@"enemy" usingBlock:^(SKNode *node, BOOL *stop) {
        Enemy *enemy = (Enemy *)node;
        enemy.position = CGPointMake(enemy.position.x - backgroundMoveSpeed * timeSinceLast, enemy.position.y);
        
        if (enemy.position.x < -200) {
            enemy.position = CGPointMake(self.size.width + arc4random() % 800, arc4random() % 240 + 40);
            enemy.hidden = NO;
        }
    }];
    
    [self enumerateChildNodesWithName:@"shieldPowerup" usingBlock:^(SKNode *node, BOOL *stop) {
        Powerup *shield = (Powerup *)node;
        shield.position = CGPointMake(shield.position.x - backgroundMoveSpeed * timeSinceLast, shield.position.y);
        
        if (shield.position.x < -200) {
            shield.position = CGPointMake(self.size.width + arc4random() % 100, arc4random() % 240 + 40);
            shield.hidden = NO;
        }
    }];
}


- (Enemy *) spawnEnemy
{
    Enemy *temp = [[Enemy alloc] init];
    temp.name = @"enemy";
    temp.position = CGPointMake(self.size.width + arc4random() % 800, arc4random() % 240 + 40);
    return temp;
}

- (Powerup *) spawnPowerup
{
    Powerup *temp = [[Powerup alloc] init];
    temp.name = @"shieldPowerup";
    temp.position = CGPointMake(self.size.width + arc4random() % 100, arc4random() % 240 + 40);
    return temp;
}

- (void) didBeginContact:(SKPhysicsContact *)contact
{
    Player *player = nil;
    
    if (contact.bodyA.categoryBitMask == playerBitmask) {
        player = (Player *) contact.bodyA.node;
        if (contact.bodyB.categoryBitMask == shieldPowerupBitmask) {
            player.shielded = YES;
            contact.bodyB.node.hidden = YES;
        }
        if (contact.bodyB.categoryBitMask == enemyBitmask) {
            [player takeDamage];
            contact.bodyB.node.hidden = YES;
        }
    } else {
        player = (Player *) contact.bodyB.node;
        if (contact.bodyA.categoryBitMask == shieldPowerupBitmask) {
            player.shielded = YES;
            contact.bodyA.node.hidden = YES;
        }
        if (contact.bodyA.categoryBitMask == enemyBitmask) {
            [player takeDamage];
            contact.bodyA.node.hidden = YES;
        }
    }
}

- (void) togglePause
{
    if (self.paused) {
        self.pauseLabel.hidden = YES;
        self.paused = NO;
    } else {
        self.pauseLabel.hidden = NO;
        self.paused = YES;
    }
}

@end

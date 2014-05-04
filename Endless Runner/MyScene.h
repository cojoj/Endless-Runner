//
//  MyScene.h
//  Endless Runner
//

//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"
@import CoreMotion;

@class Background, Player;
@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) Background *currentBackground;
@property (strong, nonatomic) Background *currentParallax;
@property (assign) CFTimeInterval lastUpdateTimeInterval;
@property (assign) double score;
@property (strong, nonatomic) SKLabelNode *scoreLabel;
@property (strong, nonatomic) CMMotionManager *manager;
@property (assign) float baseline;
@property (strong, nonatomic) UILongPressGestureRecognizer *tapper;
@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) SKLabelNode *pauseLabel;


@end

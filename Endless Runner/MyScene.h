//
//  MyScene.h
//  Endless Runner
//

//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"
@import CoreMotion;

@class Background;
@interface MyScene : SKScene

@property (strong, nonatomic) Background *currentBackground;
@property (strong, nonatomic) Background *currentParallax;
@property (assign) CFTimeInterval lastUpdateInterval;
@property (strong, nonatomic) SKLabelNode *scoreLabel;
@property (assign) double score;
@property (strong, nonatomic) CMMotionManager *manager;
@property (assign) float baseline;

@end

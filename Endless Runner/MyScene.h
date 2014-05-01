//
//  MyScene.h
//  Endless Runner
//

//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"

@class Background;
@interface MyScene : SKScene

@property (strong, nonatomic) Background *currentBackground;
@property (assign) CFTimeInterval lastUpdateInterval;
@property (strong, nonatomic) SKLabelNode *scoreLabel;
@property (assign) double score;

@end

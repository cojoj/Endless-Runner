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

@end

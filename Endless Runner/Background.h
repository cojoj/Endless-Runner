//
//  Background.h
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : SKSpriteNode

+ (Background *)generateNewBackground;
+ (Background *)generateNewParallax;

@end

//
//  Common.h
//  Endless Runner
//
//  Created by Mateusz Zając on 30.04.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#ifndef Endless_Runner_Common_h
#define Endless_Runner_Common_h

static NSString *backgroundName = @"background";
static NSInteger backgroundMoveSpeed = 200;
static NSString *playerName = @"player";
static NSInteger accelerometerMultiplier = 15;
static NSInteger playerMass = 80;
static NSInteger playerCollisionBitmask = 1;
static NSInteger playerJumpForce = 8000000;
static NSInteger globalGravity = -4.8;
static NSString *parallaxName = @"parallax";
static NSInteger parallaxMoveSpeed = 10;
static NSInteger maximumEnemies = 3;
static NSInteger maximumPowerups = 1;

const static int playerBitmask = 1;
const static int enemyBitmask = 2;
const static int shieldPowerupBitmask = 4;
const static int groundBitmask = 8;

typedef enum playerState {
    
    playerStateRunning = 0,
    playerStateJumping,
    playerStateInAir
    
} playerState;

#endif

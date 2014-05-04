//
//  GameOverScene.m
//  Endless Runner
//
//  Created by Mateusz Zając on 04.05.2014.
//  Copyright (c) 2014 Mateusz Zajac. All rights reserved.
//

#import "GameOverScene.h"
#import "MyScene.h"

@implementation GameOverScene

- (instancetype) initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        SKLabelNode *node = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        node.text = @"Game over";
        node.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        node.fontSize = 35;
        node.color = [UIColor whiteColor];
        [self addChild:node];
    }
    return self;
}

- (void) didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newGame)];
    [view addGestureRecognizer:tapper];
}

- (void) newGame
{
    MyScene *newScene = [[MyScene alloc] initWithSize:self.size];
    SKTransition *transition = [SKTransition flipHorizontalWithDuration:0.5];
    [self.view presentScene:newScene transition:transition];
}

@end

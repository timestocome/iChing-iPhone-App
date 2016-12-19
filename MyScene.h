//
//  MyScene.h
//  iChing
//
//  Created by Linda Cobb on 2/5/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Hexogram.h"

@class MainViewController;


@interface MyScene : SKScene  <SKPhysicsContactDelegate>
{
    int number;
    int barList[6];
}


@property (nonatomic, strong) Hexogram* hexogram;
@property (nonatomic, weak) MainViewController* mainViewController;


- (void)setNumber:(int)n;
- (int)getNumber;

- (void)loadHexagram;

@end

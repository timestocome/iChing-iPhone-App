//
//  MyScene.m
//  iChing
//
//  Created by Linda Cobb on 2/5/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#import "MyScene.h"
#import "MainViewController.h"



typedef NS_OPTIONS(uint32_t, CNPhysicsCategory)
{
    CNPhysicsCategoryEdge = 1 << 0,
    CNPhysicsCategoryBar = 1 << 1,
    CNPhysicsCategoryBase = 1 << 2
};



@implementation MyScene
{
    SKNode*         gameNode;
    SKSpriteNode*   bar;
    SKSpriteNode*   base;
    CGPoint         offScreen;
    CGSize          contactSize;
    int             barNumber;
    
    SKNode*         bgLayer;
    
    SKLabelNode*    titleNode;
    SKLabelNode*    descriptionNode;
    SKLabelNode*    quoteNode;
    SKLabelNode*    adviceNode;
    
    SKLabelNode*    lineNode;
    SKLabelNode*    line1Node;
    SKLabelNode*    line2Node;
    SKLabelNode*    line3Node;
    SKLabelNode*    line4Node;
    SKLabelNode*    line5Node;
    SKLabelNode*    line6Node;

}





-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        // iphone
        contactSize = CGSizeMake(300, 42 + 4.0 );

        
        CGRect tabFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height );        
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:tabFrame];
        self.physicsBody.categoryBitMask = CNPhysicsCategoryEdge;
        
        bgLayer = [SKNode node];
        [self addChild:bgLayer];
        
        for ( int i=0; i<2; i++){
            SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"comet background iphone"];
            
            if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){
                bg = [SKSpriteNode spriteNodeWithImageNamed:@"comet background"];
                contactSize = CGSizeMake(600, 42 + 4.0 );
                [self addBase];
            }
            
            bg.anchorPoint = CGPointZero;
            bg.position = CGPointMake(0, i * bg.size.width);
            
            bg.name = @"bg";
            [bgLayer addChild:bg];
        }
        
        
        offScreen = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-1);
    
        
        
       [self loadHexagram];
    }
    return self;
}


- (void)clearAll
{
    [self enumerateChildNodesWithName:@"bar" usingBlock:^(SKNode* node, BOOL* stop){
        [node runAction:[SKAction sequence:@[
                                             [SKAction scaleTo:0 duration:1.0],
                                               [SKAction removeFromParent]]]];
         }];
    if ( base ){ [base removeFromParent]; }
    if ( titleNode ){ [titleNode removeFromParent]; }
    if ( descriptionNode ){ [descriptionNode removeFromParent]; }
    if ( quoteNode ){ [quoteNode removeFromParent]; }
    if ( adviceNode ){ [adviceNode removeFromParent]; }
    if ( lineNode ){ [lineNode removeFromParent]; }
    if ( line1Node ){ [line1Node removeFromParent]; }
    if ( line2Node ){ [line2Node removeFromParent]; }
    if ( line3Node ){ [line3Node removeFromParent]; }
    if ( line4Node ){ [line4Node removeFromParent]; }
    if ( line5Node ){ [line5Node removeFromParent]; }
    if ( line6Node ){ [line6Node removeFromParent]; }


    self.mainViewController.reloadButton.hidden = YES;
    self.mainViewController.detailsButton.hidden = YES;
    self.mainViewController.shareButton.hidden = YES;
}





- (void)loadHexagram
{
    [self clearAll];
    
    if ( number == 0 ){ [self getRandomNumber]; }
    
    NSLog(@"hex number %d", number);

    
    self.hexogram = [[Hexogram alloc] getHexogram:number];
    [self createHex:number];
    
    
}






- (void)addBase
{
    
        base = [SKSpriteNode spriteNodeWithImageNamed:@"base.png"];
        base.name = @"base";
        base.position = CGPointMake(1.0, 1.0);
        base.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1024, 80)];
        base.physicsBody.restitution = 0.6;
        base.physicsBody.allowsRotation = NO;
        base.physicsBody.categoryBitMask = CNPhysicsCategoryBase;
        base.physicsBody.contactTestBitMask = CNPhysicsCategoryBase;
        base.physicsBody.collisionBitMask = CNPhysicsCategoryBar | CNPhysicsCategoryEdge | CNPhysicsCategoryBase;
    
        [self addChild:base];
 
}


- (void)loadTitle
{
    titleNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
    titleNode.text = self.hexogram.name;
    titleNode.fontSize = 30;
    titleNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70.0);
    titleNode.name = @"title";
    
    [self addChild:titleNode];
    
    descriptionNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
    descriptionNode.text = self.hexogram.description;
    descriptionNode.fontSize = 14;
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){ descriptionNode.fontSize = 15; }
    
    descriptionNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 100.0);
    descriptionNode.name = @"desciption";
    
    [self addChild:descriptionNode];

    
   
    
    self.mainViewController.reloadButton.hidden = NO;
    self.mainViewController.detailsButton.hidden = NO;
    self.mainViewController.shareButton.hidden = NO;
    
    
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){
    
        adviceNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        adviceNode.text = self.hexogram.advice;
        adviceNode.fontSize = 15;
        
        adviceNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 150.0);
        adviceNode.name = @"advice";
        
        [self addChild:adviceNode];
        
        quoteNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        quoteNode.text = self.hexogram.quote;
        quoteNode.fontSize = 15;
        if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){ quoteNode.fontSize = 15; }
        
        quoteNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 125.0);
        quoteNode.name = @"quote";
        
        [self addChild:quoteNode];

        
        
        lineNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        lineNode.text = @"Six Lines:";
        lineNode.fontSize = 15;
        line1Node.fontColor = [UIColor redColor];
        lineNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 175.0);
        lineNode.name = @"line";
        
        [self addChild:lineNode];


        line1Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line1Node.text = self.hexogram.one;
        line1Node.fontSize = 15;
        
        line1Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 200.0);
        line1Node.name = @"one";
        
        [self addChild:line1Node];
        
        line2Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line2Node.text = self.hexogram.two;
        line2Node.fontSize = 15;
        
        line2Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 225.0);
        line2Node.name = @"two";
        
        [self addChild:line2Node];

        
        line3Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line3Node.text = self.hexogram.three;
        line3Node.fontSize = 15;
        
        line3Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 250.0);
        line3Node.name = @"three";
        
        [self addChild:line3Node];
        
        line4Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line4Node.text = self.hexogram.four;
        line4Node.fontSize = 15;
        
        line4Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 275.0);
        line4Node.name = @"four";
        
        [self addChild:line4Node];


        line5Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line5Node.text = self.hexogram.five;
        line5Node.fontSize = 15;
        
        line5Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 300.0);
        line5Node.name = @"five";
        
        [self addChild:line5Node];
        
        
        line6Node = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
        line6Node.text = self.hexogram.six;
        line6Node.fontSize = 15;
        
        line6Node.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 325.0);
        line6Node.name = @"six";
        
        [self addChild:line6Node];


    }

    
}



- (void)setNumber:(int)n
{
    number = n;
}

- (int)getNumber
{
    return number;
}



- (void)getRandomNumber
{
    
    // six  1/16 (1)                        -x- broken
    // eight 5/16 (2,3,4,5,6,7,8)               - - broken
    // nine 3/16 (9,10,11)                    -o- solid
    // seven 7/16 (12,13,14,15,16)    --- solid
    
    int bar_count = 0;
    for (int i=1; i<=6; i++){
        
        int bar_type = arc4random_uniform(16) + 1;
        
        if (bar_type == 1){
            barList[bar_count] = 6;
            
        }else if ( bar_type < 9){
            barList[bar_count] = 8;
        
        }else if ( bar_type < 12){
            barList[bar_count] = 9;
        
        }else {
            barList[bar_count] = 7;
        }
        
        
        //NSLog(@"bar_type %d, %d", bar_type, barList[bar_count]);

        bar_count++;
    }
    
    // dropping bars bottom first so need to reverse order the lines
    NSLog(@"bottom %d %d %d", barList[5], barList[4], barList[3]);
    NSLog(@" top %d %d %d", barList[2], barList[1], barList[0]);
    
    
    // convert from 4 possibilities back to 2 to get correct hex
    // 6, 8 broken
    // 7, 9 solid
    
    int bottom = 0;
    if      (barList[2]%2 == 1 && barList[1]%2 == 1 && barList[0]%2 == 1){ bottom = 0; }
    else if (barList[2]%2 == 0 && barList[1]%2 == 0 && barList[0]%2 == 1){ bottom = 1; }
    else if (barList[2]%2 == 0 && barList[1]%2 == 1 && barList[0]%2 == 0){ bottom = 2; }
    else if (barList[2]%2 == 1 && barList[1]%2 == 0 && barList[0]%2 == 0){ bottom = 3; }
    else if (barList[2]%2 == 0 && barList[1]%2 == 0 && barList[0]%2 == 0){ bottom = 4; }
    else if (barList[2]%2 == 1 && barList[1]%2 == 1 && barList[0]%2 == 0){ bottom = 5; }
    else if (barList[2]%2 == 1 && barList[1]%2 == 0 && barList[0]%2 == 1){ bottom = 6; }
    else if (barList[2]%2 == 0 && barList[1]%2 == 1 && barList[0]%2 == 1){ bottom = 7; }

    
    int top = 0;
    if      (barList[5]%2 == 1 && barList[4]%2 == 1 && barList[3]%2 == 1){ top = 0; }
    else if (barList[5]%2 == 0 && barList[4]%2 == 0 && barList[3]%2 == 1){ top = 1; }
    else if (barList[5]%2 == 0 && barList[4]%2 == 1 && barList[3]%2 == 0){ top = 2; }
    else if (barList[5]%2 == 1 && barList[4]%2 == 0 && barList[3]%2 == 0){ top = 3; }
    else if (barList[5]%2 == 0 && barList[4]%2 == 0 && barList[3]%2 == 0){ top = 4; }
    else if (barList[5]%2 == 1 && barList[4]%2 == 1 && barList[3]%2 == 0){ top = 5; }
    else if (barList[5]%2 == 1 && barList[4]%2 == 0 && barList[3]%2 == 1){ top = 6; }
    else if (barList[5]%2 == 0 && barList[4]%2 == 1 && barList[3]%2 == 1){ top = 7; }
    
    
    

    if ( top == 0 && bottom == 0 ){ number = 1; }
    else if ( top == 0 && bottom == 1){ number = 25; }
    else if ( top == 0 && bottom == 2){ number = 6; }
    else if ( top == 0 && bottom == 3){ number = 33; }
    else if ( top == 0 && bottom == 4){ number = 12; }
    else if ( top == 0 && bottom == 5){ number = 44; }
    else if ( top == 0 && bottom == 6){ number = 13; }
    else if ( top == 0 && bottom == 7){ number = 10; }
    
    if ( top == 1 && bottom == 0 ){ number = 34; }
    else if ( top == 1 && bottom == 1){ number = 51; }
    else if ( top == 1 && bottom == 2){ number = 40; }
    else if ( top == 1 && bottom == 3){ number = 62; }
    else if ( top == 1 && bottom == 4){ number = 16; }
    else if ( top == 1 && bottom == 5){ number = 32; }
    else if ( top == 1 && bottom == 6){ number = 55; }
    else if ( top == 1 && bottom == 7){ number = 54; }
    
    if ( top == 2 && bottom == 0 ){ number = 5; }
    else if ( top == 2 && bottom == 1){ number = 3; }
    else if ( top == 2 && bottom == 2){ number = 29; }
    else if ( top == 2 && bottom == 3){ number = 39; }
    else if ( top == 2 && bottom == 4){ number = 8; }
    else if ( top == 2 && bottom == 5){ number = 48; }
    else if ( top == 2 && bottom == 6){ number = 63; }
    else if ( top == 2 && bottom == 7){ number = 60; }

    
    if ( top == 3 && bottom == 0 ){ number = 26; }
    else if ( top == 3 && bottom == 1){ number = 27; }
    else if ( top == 3 && bottom == 2){ number = 4; }
    else if ( top == 3 && bottom == 3){ number = 52; }
    else if ( top == 3 && bottom == 4){ number = 23; }
    else if ( top == 3 && bottom == 5){ number = 18; }
    else if ( top == 3 && bottom == 6){ number = 22; }
    else if ( top == 3 && bottom == 7){ number = 41; }

    
    if ( top == 4 && bottom == 0 ){ number = 11; }
    else if ( top == 4 && bottom == 1){ number = 24; }
    else if ( top == 4 && bottom == 2){ number = 7; }
    else if ( top == 4 && bottom == 3){ number = 15; }
    else if ( top == 4 && bottom == 4){ number = 2; }
    else if ( top == 4 && bottom == 5){ number = 46; }
    else if ( top == 4 && bottom == 6){ number = 36; }
    else if ( top == 4 && bottom == 7){ number = 19; }
    

    if ( top == 5 && bottom == 0 ){ number = 9; }
    else if ( top == 5 && bottom == 1){ number = 42; }
    else if ( top == 5 && bottom == 2){ number = 59; }
    else if ( top == 5 && bottom == 3){ number = 53; }
    else if ( top == 5 && bottom == 4){ number = 20; }
    else if ( top == 5 && bottom == 5){ number = 57; }
    else if ( top == 5 && bottom == 6){ number = 37; }
    else if ( top == 5 && bottom == 7){ number = 61; }
    

    if ( top == 6 && bottom == 0 ){ number = 14; }
    else if ( top == 6 && bottom == 1){ number = 21; }
    else if ( top == 6 && bottom == 2){ number = 64; }
    else if ( top == 6 && bottom == 3){ number = 56; }
    else if ( top == 6 && bottom == 4){ number = 35; }
    else if ( top == 6 && bottom == 5){ number = 50; }
    else if ( top == 6 && bottom == 6){ number = 30; }
    else if ( top == 6 && bottom == 7){ number = 38; }
    
    
    if ( top == 7 && bottom == 0 ){ number = 43; }
    else if ( top == 7 && bottom == 1){ number = 17; }
    else if ( top == 7 && bottom == 2){ number = 47; }
    else if ( top == 7 && bottom == 3){ number = 31; }
    else if ( top == 7 && bottom == 4){ number = 45; }
    else if ( top == 7 && bottom == 5){ number = 28; }
    else if ( top == 7 && bottom == 6){ number = 49; }
    else if ( top == 7 && bottom == 7){ number = 58; }

    NSLog(@"top %d, bottom %d", top, bottom);
    NSLog(@"Number %d", number);
	//number = rand()%64 + 1;
}



- (void)createBar
{
   // NSString *barList = self.hexogram.hexSymbol;
   // NSUInteger type = [[barList substringWithRange:NSMakeRange(barNumber,1)] integerValue];
    
    int type = barList[barNumber];
    
    if ( type == 6 ) bar = [SKSpriteNode spriteNodeWithImageNamed:@"six.png"];
    else if ( type == 7 ) bar = [SKSpriteNode spriteNodeWithImageNamed:@"seven.png"];
    else if ( type == 8 ) bar = [SKSpriteNode spriteNodeWithImageNamed:@"eight.png"];
    else if ( type == 9 ) bar = [SKSpriteNode spriteNodeWithImageNamed:@"nine.png"];
    
    
    bar.name = @"bar";
    bar.position = offScreen;
    
    bar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:contactSize];
    bar.physicsBody.restitution = 0.6;
    bar.physicsBody.categoryBitMask = CNPhysicsCategoryBar;
    bar.physicsBody.contactTestBitMask = CNPhysicsCategoryBar;
    bar.physicsBody.collisionBitMask = CNPhysicsCategoryBar | CNPhysicsCategoryEdge | CNPhysicsCategoryBase;
    
    [self addChild:bar];
    
    barNumber++;
}




- (void)createHex:(int)hexNumber
{
    
    
    
    
    barNumber = 0;
    [self runAction:[SKAction repeatAction:[SKAction sequence:
                                            @[[SKAction performSelector:@selector(createBar) onTarget:self],
                                              [SKAction waitForDuration:1.2]]]
                                     count:6]
         completion:^(void){ [self loadTitle]; }];
}



- (void)update:(NSTimeInterval)currentTime
{
    [self moveBg];
}



- (void)didBeginContact:(SKPhysicsContact *)contact
{
 //    NSLog(@"\nContact: %@\n %@\n", contact.bodyA, contact.bodyB);
}



- (void)moveBg
{
    bgLayer.position = CGPointMake ( bgLayer.position.x, bgLayer.position.y - .1);
    
    [bgLayer enumerateChildNodesWithName:@"bg" usingBlock:^(SKNode* node, BOOL *stop){
        SKSpriteNode* bg = (SKSpriteNode *)node;
        CGPoint bgScreenPos = [bgLayer convertPoint:bg.position toNode:self];
        
        if ( bgScreenPos.x <= -bg.size.width ){
            bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
        }
    }];
}





@end

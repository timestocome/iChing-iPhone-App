//
//  MainViewController.h
//  iChing
//
//  Created by Linda Cobb on 2/5/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "Hexogram.h"
#import "SixLinesViewController.h"
#import "MyScene.h"


@interface MainViewController : UIViewController
{
    int number;
}


@property (nonatomic, retain) MyScene* myScene;

@property (nonatomic, retain) IBOutlet UIButton* reloadButton;
@property (nonatomic, retain) IBOutlet UIButton* detailsButton;
@property (nonatomic, retain) IBOutlet UIButton* shareButton;

@property (nonatomic, weak) UITabBarController* tabBarController;


- (void)setNumber:(int)n;
- (IBAction)reload:(id)sender;
- (IBAction)details:(id)sender;
- (IBAction)share:(id)sender;

@end

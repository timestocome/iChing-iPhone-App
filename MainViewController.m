//
//  MainViewController.m
//  iChing
//
//  Created by Linda Cobb on 2/5/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "MyScene.h"
#import "ListViewController.h"


@implementation MainViewController





- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.reloadButton.hidden = YES;
    self.detailsButton.hidden = YES;
    self.shareButton.hidden = YES;
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if ( ! skView.scene ){
    
        // Create and configure the scene.
        CGSize tabSize = CGSizeMake(skView.bounds.size.width, skView.bounds.size.height - 70);
        SKScene* scene = [MyScene sceneWithSize:tabSize];
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        _myScene = (MyScene *)scene;
        self.myScene.mainViewController = self;
  
        // Present the scene.
        [skView presentScene:self.myScene];
    }
}




- (void)setNumber:(int)n
{
    number = n;
    [self.myScene setNumber:number];
}



- (IBAction)reload:(id)sender
{
    [self.myScene setNumber:0];
    [self.myScene loadHexagram];
}



- (IBAction)details:(id)sender
{
    
    number = [self.myScene getNumber];

    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
    UINavigationController *navigationController = [self.tabBarController.viewControllers objectAtIndex:1];
    ListViewController *listViewController = [navigationController.viewControllers objectAtIndex:0];
    
    [listViewController setNumber:number-1];
    [listViewController performSegueWithIdentifier:@"DetailSegue" sender:self];
    
}




- (IBAction)share:(id)sender
{
    number = [self.myScene getNumber];
    
    Hexogram* hexogram = [[Hexogram alloc] getHexogram:number];
    
    NSMutableString *hexagramString = [[NSMutableString alloc] initWithString:hexogram.name];
    
    [hexagramString appendString:[NSString stringWithFormat:@"\n%@ %@", hexogram.elementName1, hexogram.elementName2]];
    [hexagramString appendString:[NSString stringWithFormat:@"\n%@", hexogram.description]];
    [hexagramString appendString:[NSString stringWithFormat:@"\n%@", hexogram.quote]];
    [hexagramString appendString:[NSString stringWithFormat:@"\n%@", hexogram.advice]];
    
    
    NSArray *shareItem = @[hexagramString];
    
   UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareItem applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
    
}




-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.myScene loadHexagram];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  AppDelegate.h
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "Hexogram.h"
#import "MainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSTimeZone *timeZone;



- (void) loadNotifications;
- (void) removeAlerts;



@end

//
//  AppDelegate.m
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.applicationIconBadgeNumber = 0;
    
    // set time zone
    self.timeZone = [NSTimeZone localTimeZone];
    
   
    //check notification stack has plenty of stuff in it, reload them if needed
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [[defaults objectForKey:@"notificationsOn"]intValue] == 1){
        

        [self loadNotifications];
    }
    
    [self tabBarSetup];
    
   
    
    return YES;
}




- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    if ( application.applicationState == UIApplicationStateInactive){
        
        // tab bar setup
        [self tabBarSetup];
        
        // take user to proper detail view
        NSNumber *hexNumber = [notification.userInfo objectForKey:@"hexNumber"];
        
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        tabBarController.selectedViewController = [tabBarController.viewControllers objectAtIndex:1];
        
        UINavigationController *navigationController = [tabBarController.viewControllers objectAtIndex:1];
        ListViewController *listViewController = [navigationController.viewControllers objectAtIndex:0];
        
        [listViewController setNumber:hexNumber.intValue-1];
        [listViewController performSegueWithIdentifier:@"DetailSegue" sender:self];

    }
}



- (void)tabBarSetup
{
    // tab bar setup
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBarBackground.png"]];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor redColor]];
    
    
    NSMutableArray *viewControllers = (NSMutableArray *)tabBarController.viewControllers;
    MainViewController *mainViewController = [viewControllers objectAtIndex:0];
    mainViewController.tabBarController = tabBarController;

}





- (void) loadNotifications
{
    
    
    UIApplication *app = [UIApplication sharedApplication];
	NSArray *oldNotifications = [app scheduledLocalNotifications];
	int stackCount = (int)[oldNotifications count];
	int minNotifications = 12;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int notificationTime = [[defaults objectForKey:@"notificationTime"] intValue];
    if ((notificationTime <=0) || (notificationTime > 24)){ notificationTime = 11; }
    
   // NSLog(@"loading notifications for time %d", notificationTime);
    
    // reload notifications if less than a dozen remain
	if ( stackCount < minNotifications ){
        
        //erase old
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        
        // load up a random collection of iChing hexagrams to put into alerts
        // need a random array from 1-64
        NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],
                                [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5],
                                [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [NSNumber numberWithInt:8], [NSNumber numberWithInt:9],
                                [NSNumber numberWithInt:10], [NSNumber numberWithInt:11], [NSNumber numberWithInt:12], [NSNumber numberWithInt:13],
                                [NSNumber numberWithInt:14], [NSNumber numberWithInt:15], [NSNumber numberWithInt:16], [NSNumber numberWithInt:17],
                                [NSNumber numberWithInt:18], [NSNumber numberWithInt:19], [NSNumber numberWithInt:20], [NSNumber numberWithInt:21],
                                [NSNumber numberWithInt:22], [NSNumber numberWithInt:23], [NSNumber numberWithInt:24], [NSNumber numberWithInt:25],
                                [NSNumber numberWithInt:26], [NSNumber numberWithInt:27], [NSNumber numberWithInt:28], [NSNumber numberWithInt:29],
                                [NSNumber numberWithInt:30], [NSNumber numberWithInt:31], [NSNumber numberWithInt:32], [NSNumber numberWithInt:33],
                                [NSNumber numberWithInt:34], [NSNumber numberWithInt:35], [NSNumber numberWithInt:36], [NSNumber numberWithInt:37],
                                [NSNumber numberWithInt:38], [NSNumber numberWithInt:39], [NSNumber numberWithInt:40], [NSNumber numberWithInt:41],
                                [NSNumber numberWithInt:42], [NSNumber numberWithInt:43], [NSNumber numberWithInt:44], [NSNumber numberWithInt:45],
                                [NSNumber numberWithInt:46], [NSNumber numberWithInt:47], [NSNumber numberWithInt:48], [NSNumber numberWithInt:49],
                                [NSNumber numberWithInt:50], [NSNumber numberWithInt:51], [NSNumber numberWithInt:52], [NSNumber numberWithInt:53],
                                [NSNumber numberWithInt:54], [NSNumber numberWithInt:55], [NSNumber numberWithInt:56], [NSNumber numberWithInt:57],
                                [NSNumber numberWithInt:58], [NSNumber numberWithInt:59], [NSNumber numberWithInt:60], [NSNumber numberWithInt:61],
                                [NSNumber numberWithInt:62], [NSNumber numberWithInt:63], [NSNumber numberWithInt:64], nil];
        
        
        NSMutableArray *random = [[NSMutableArray alloc] initWithCapacity:64];
        
        
        int r;
        int c = 64 - 1;
        int j = 0;
        
        for ( int i=c; i>0; i--){
            
            r = rand()%i;
            
            [random insertObject:[list objectAtIndex:r] atIndex:j];
            [list removeObjectAtIndex:r];
            
            j++;
        }
        
        [random insertObject:[list objectAtIndex:0] atIndex:j];	// fetch last object --- crashes loop if placed inside or skips last
        
        
        
        
        
        // put together a list of hexagram names and descriptions from the random list
        Hexogram *hexogram = [[Hexogram alloc] init];
        
        
        // init calendar and date parts
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
       
        [components setHour:notificationTime];
        [components setMinute:0];
        
        [components setHour:notificationTime];
        NSDate *startDate = [calendar dateFromComponents:components];
        
        
        for ( int i=0; i<64; i++){
            
            // set up new notification
            UILocalNotification *newNotification = [[UILocalNotification alloc] init];
            [newNotification setTimeZone:self.timeZone];
            
            startDate = [calendar dateFromComponents:components];
            [newNotification setFireDate:startDate];
            
            components.day++;  // move to next day
            
            
            
            // set user dictionary - hex number, text
            int hexogramNumber = [[random objectAtIndex:i] intValue];
            hexogram = [[Hexogram alloc] getHexogram:hexogramNumber];
        
            // set alert message    
            [newNotification setAlertBody:[NSString stringWithFormat:@"%d, %@\n%@", hexogramNumber, hexogram.name, hexogram.description]];
            

            NSDictionary *userInfo = [[NSDictionary alloc]  initWithObjectsAndKeys:
                                      [random objectAtIndex:i], @"hexNumber",
                                      nil];
            [newNotification setUserInfo:userInfo];

            // set notification into the system queue
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
            
           // NSLog(@"scheduled notification %@", newNotification);
        }
    }
}







- (void)removeAlerts
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}



@end

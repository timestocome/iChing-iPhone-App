//
//  SettingsViewController.m
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"



@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}




- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];

    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    notificationsOn = [[self.defaults objectForKey:@"notificationsOn"]intValue];
    [self.notificationSwitch setOn:notificationsOn];
    
    notificationTime = [[self.defaults objectForKey:@"notificationTime"] intValue];
    if (notificationTime <= 0){ notificationTime = 11; }
    [self.notificationTimeSlider setValue:notificationTime];
    [self.notificationTimeLabel setText:[NSString stringWithFormat:@"%d", notificationTime]];
                                           
}







- (IBAction)notificationsChange:(id)sender
{
    
    NSLog(@"change notifications");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    notificationsOn = self.notificationSwitch.on;
    
    if ( self.notificationSwitch.on == YES ){
        
        
        
        // None of the code should even be compiled unless the Base SDK is iOS 8.0 or later
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        
        UIApplication *application = [UIApplication sharedApplication];
        
        // The following line must only run under iOS 8. This runtime check prevents
        
    
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        }
        #endif

		[self.defaults setObject:[NSNumber numberWithInt:1] forKey:@"notificationsOn"];
        [self.defaults setObject:[NSNumber numberWithInt:notificationTime] forKey:@"notificationTime"];
        [self.defaults synchronize];
        
        [appDelegate loadNotifications];
	}else{
		[self.defaults setObject:[NSNumber numberWithInt:0] forKey:@"notificationsOn"];
        [self.defaults synchronize];

        [appDelegate removeAlerts];
	}
}





-(IBAction)changeNotificationTime:(id)sender
{
    notificationTime = [self.notificationTimeSlider value];
    
    if (notificationsOn == 1){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [appDelegate removeAlerts];
        [appDelegate loadNotifications];
    }
}




-(IBAction)updateTimeLabel:(id)sender
{
    notificationTime = [self.notificationTimeSlider value];
    
    [self.notificationTimeLabel setText:[NSString stringWithFormat:@"%d", notificationTime]];
    [self.defaults setObject:[NSNumber numberWithInt:notificationTime] forKey:@"notificationTime"];
    [self.defaults synchronize];

}





- (IBAction)email:(id)sender
{
    
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			// send the email
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			
            if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){
                [picker setSubject:[NSString stringWithFormat:@"iChing 10.4 iPad Request"]];
            }else{
                [picker setSubject:[NSString stringWithFormat:@"iChing 10.4 iPhone Request"]];
            }
            
			[picker setToRecipients:[NSArray arrayWithObject:@"timestocome@gmail.com"]];
			
            [self presentViewController:picker animated:YES completion:NULL];
            
		}
	}
}










// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}







-(IBAction)gift:(id)sender
{
    NSString *GiftAppURL = [NSString stringWithFormat:@"itms-appss://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=%d&productType=C&pricingParameter=STDQ&mt=8&ign-mscache=1",297845092];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:GiftAppURL]];
    
}


-(IBAction)share:(id)sender
{
    NSString *messageString = @"iChing Link: itms-apps://itunes.apple.com/us/app/fit-test/id297845092?mt=8";
    NSArray *shareItem = @[messageString];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareItem applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
    
}


-(IBAction)rate:(id)sender
{
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id297845092"]];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

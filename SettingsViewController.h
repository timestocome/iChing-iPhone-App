//
//  SettingsViewController.h
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    int notificationsOn;
    int notificationTime;
}



@property (nonatomic, weak) IBOutlet UIButton *websiteButton;
@property (nonatomic, weak) IBOutlet UIButton *emailButton;
@property (nonatomic, weak) IBOutlet UISwitch *notificationSwitch;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, retain) IBOutlet UISlider *notificationTimeSlider;
@property (nonatomic, retain) IBOutlet UILabel *notificationTimeLabel;


-(IBAction)email:(id)sender;
-(IBAction)notificationsChange:(id)sender;
-(IBAction)changeNotificationTime:(id)sender;
-(IBAction)updateTimeLabel:(id)sender;




-(IBAction)gift:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)rate:(id)sender;

@end

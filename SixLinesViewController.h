//
//  SixLinesViewController.h
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hexogram.h"


@interface SixLinesViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) NSNumber *number;

//- (void)setNumber:(NSNumber *)number;
- (IBAction)closeView:(id)sender;

@end

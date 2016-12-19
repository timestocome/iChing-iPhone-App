//
//  DetailViewController.h
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hexogram.h"

@interface DetailViewController : UITableViewController
{
    double newRowHeight;
    CGSize newTextViewHeight;
}


@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) Hexogram *hexogram;
@property (nonatomic, strong) UIColor *red;



@end

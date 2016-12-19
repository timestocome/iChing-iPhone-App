//
//  ListViewController.h
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hexogram.h"
#import "DetailViewController.h"


@interface ListViewController : UITableViewController
{
    int number;
}


- (void)setNumber:(int)n;

@end

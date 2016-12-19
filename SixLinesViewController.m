//
//  SixLinesViewController.m
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "SixLinesViewController.h"



@implementation SixLinesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Hexogram *hexogram = [[Hexogram alloc] getHexogram:self.number.intValue];
    
    NSMutableString *sixLinesString = [NSMutableString new];
    
    NSString *one = [NSString stringWithFormat:@"%@\n\n", hexogram.one];
    NSString *two = [NSString stringWithFormat:@"%@\n\n", hexogram.two];
    NSString *three = [NSString stringWithFormat:@"%@\n\n", hexogram.three];
    NSString *four = [NSString stringWithFormat:@"%@\n\n", hexogram.four];
    NSString *five = [NSString stringWithFormat:@"%@\n\n", hexogram.five];
    NSString *six = [NSString stringWithFormat:@"%@\n\n", hexogram.six];
    
    [sixLinesString appendString:one];
    [sixLinesString appendString:two];
    [sixLinesString appendString:three];
    [sixLinesString appendString:four];
    [sixLinesString appendString:five];
    [sixLinesString appendString:six];
    
    [self.textView setText:sixLinesString];
    
}

- (IBAction)closeView:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

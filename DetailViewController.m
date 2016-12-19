//
//  DetailViewController.m
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    
        self.hexogram = [[Hexogram alloc] getHexogram:self.number.intValue];
        self.title = [self.hexogram name];
        [self.tableView setBackgroundView:nil];

    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.red = [UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0];
    newRowHeight = 44.0;
    [self preferredContentSizeChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.hexogram = [[Hexogram alloc] getHexogram:self.number.intValue];
    self.title = [self.hexogram name];
    
    [self.tableView setBackgroundView:nil];

}



- (void)preferredContentSizeChanged
{
    
    // get new rowHeight for fontSize
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.text = @"calc row height";
    [label sizeToFit];
    
    newRowHeight = label.frame.size.height * 1.7 * 2.0;
    
    newTextViewHeight = CGSizeMake(self.view.frame.size.width, newRowHeight - 20.0);
    
    
    [self.tableView reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (section) {
		case 0:
			rows = 1;
			break;
        case 1:
			rows = 3;
			break;
		case 2:
			rows = 6;
			break;
		default:
            break;
    }
    
    return rows;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ){ return 60.0; }
    else{ return newRowHeight; }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    if ( indexPath.section == 0 ){
        
        static NSString *CellIdentifier = @"ImageCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        UIImageView *hex1 = (UIImageView *)[cell viewWithTag:101];
        hex1.image = [UIImage imageNamed:self.hexogram.element1];
        
        UIImageView *hex2 = (UIImageView *)[cell viewWithTag:102];
        hex2.image = [UIImage imageNamed:self.hexogram.element2];
        
        UILabel *element1 = (UILabel *)[cell viewWithTag:103];
        element1.text = [self.hexogram elementName1];
        element1.textColor = self.red;
            
        
        UILabel *element2 = (UILabel *)[cell viewWithTag:104];
        element2.text = [self.hexogram elementName2];
        element2.textColor = self.red;
        
        
        return cell;
        
    }else if (indexPath.section == 1 ){
        
        static NSString *CellIdentifier = @"DescriptionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        UILabel *textView = (UILabel *)[cell viewWithTag:201];
        
        if ( indexPath.row == 0 ){
            textView.text = [self.hexogram description];;
        }else if ( indexPath.row == 1 ){
            textView.text = [self.hexogram quote];
        }else {
            textView.text = [self.hexogram advice];
        }
        
        CGRect newSize = CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height);
        textView.frame = newSize;
        
        
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"SixLinesCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        UITextView *textView = (UITextView *)[cell viewWithTag:301];
        
        if ( indexPath.row == 0 ){
            textView.text = [self.hexogram one];
        }else if ( indexPath.row == 1 ){
            textView.text = [self.hexogram two];
        }else if ( indexPath.row == 2 ){
            textView.text = [self.hexogram three];
        }else if ( indexPath.row == 3 ){
            textView.text = [self.hexogram four];
        }else if ( indexPath.row == 4 ){
            textView.text = [self.hexogram five];
        }else {
            textView.text = [self.hexogram six];
        }
        
        CGRect newSize = CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height);
        textView.frame = newSize;
        
        return  cell;
    }
    
}



// Provide section titles
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section == 0 ){ return  0.0; }
    else {  return 20.0; }
}



- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *hdr = [[UILabel alloc] init];
    
    hdr.backgroundColor = [UIColor blackColor];
    hdr.font = [UIFont italicSystemFontOfSize:18.0];
    hdr.opaque = YES;
    hdr.textColor = self.red;
    hdr.textAlignment = NSTextAlignmentCenter;
    
    switch (section) {
        case 0:
            hdr.text = @"";
            break;
        case 1:
            hdr.text = @"Description";
            break;
        case 2:
            hdr.text = @"Six Lines";
            break;
        case 3:
            hdr.text = @"";
            break;
        default:
            break;
    }
    
    return hdr;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end

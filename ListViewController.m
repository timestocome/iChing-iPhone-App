//
//  ListViewController.m
//  iChing
//
//  Created by Linda Cobb on 7/2/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "ListViewController.h"


@implementation ListViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {}
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Hexogram *hexagram = [[Hexogram alloc] getHexogram:(int)(indexPath.row+1)];
    
    // Configure the cell...
    UILabel *hexagramLabel = (UILabel *)[cell viewWithTag:101];
    hexagramLabel.text = [NSString stringWithFormat:@"%d %@", (indexPath.row+1), [hexagram name]];
    
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:102];
    descriptionLabel.text = [hexagram description];
    
    return cell;
}


- (void)setNumber:(int)n
{
    number = n;
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (number > 0 ){
            indexPath = [NSIndexPath indexPathForRow:number inSection:0];
        }
        [(DetailViewController *)[segue destinationViewController] setNumber:[NSNumber numberWithInt:((int)indexPath.row + 1)]];
        number = 0;
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
 

@end

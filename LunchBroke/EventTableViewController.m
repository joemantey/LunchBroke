//
//  LocationsTableViewController.m
//  LnchBrkr
//
//  Created by Ian Smith on 3/16/15.
//  Copyright (c) 2015 Ian Smith. All rights reserved.
//

#import "EventTableViewController.h"
#import <Parse/Parse.h>
#import "Locations.h"
#import <UIColor+uiGradients.h>
#import "EventTableViewCell.h"

@interface EventTableViewController ()

- (IBAction)pullToRefresh:(id)sender;

@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setColors];
    [self fetchLocations];
    [self.tableView reloadData];
    
    
    
}



-(void)setColors
{
    //set the color of the bar
    [self.navigationController.navigationBar setBarTintColor:[UIColor uig_namnStartColor]];
    
    //turn the bar opaque
    [self.navigationController.navigationBar setTranslucent:NO];

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.tableView.bounds;
    gradient.startPoint = CGPointZero;
    gradient.endPoint = CGPointMake(0, 1);
    gradient.colors = [NSArray arrayWithObjects: (id)[[UIColor whiteColor] CGColor], (id)[[UIColor whiteColor]CGColor], nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self fetchLocations];
}

-(void) fetchLocations
{
    PFQuery *locationCount = [PFQuery queryWithClassName:@"Event"];
    [locationCount findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.locationArray = [NSMutableArray arrayWithArray:objects];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locationArray count];
}

//makes cells taller
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
   
    Locations *location = self.locationArray[indexPath.row];
    cell.eventName.text = location[@"location"];
  
    
    cell.eventDate.text = @"Date: April 3rd, 2015";
    cell.eventAttendeeCount.text = @"Attendees: 10";
    cell.eventDate.textColor = [UIColor darkGrayColor];
    cell.eventAttendeeCount.textColor = [UIColor darkGrayColor];
    //UIToolbar *translucentView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    
    //cell.backgroundView = translucentView;
    //[translucentView release]; // If you are using retain/release for memory management(non-ARC).
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)pullToRefresh:(id)sender {
    [self fetchLocations];
    [sender endRefreshing];
}


@end

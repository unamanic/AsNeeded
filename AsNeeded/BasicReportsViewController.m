//
//  BasicReportsViewController.m
//  AsNeeded
//
//  Created by William Witt on 1/4/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "BasicReportsViewController.h"
#import "AsNeededAppDelegate.h"
#import "User.h"
#import "Medication.h"
#import "MedicationAdministration.h"

@interface BasicReportsViewController () {
    AsNeededAppDelegate *appDelegate;
    
    User *user;
    NSArray *medications;
    NSMutableDictionary *medicationAdministrations;
}

@end

@implementation BasicReportsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [UIApplication sharedApplication].delegate;
    
    user = [appDelegate fetchUser];
    
    medications = [user.medications allObjects];
    medicationAdministrations = [[NSMutableDictionary alloc] init];
    for (Medication *m in medications) {
        [medicationAdministrations setObject:[m.medicationAdministrations allObjects] forKey:m.name];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return user.medications.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[medications objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2; //[(NSArray *)([medicationAdministrations objectForKey:[[medications objectAtIndex:section] name]]) count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"ReportCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Medication *m = [medications objectAtIndex:indexPath.section];
    MedicationAdministration *ma = [[medicationAdministrations objectForKey:[[medications objectAtIndex:indexPath.section] name]] objectAtIndex:indexPath.row];

    // Configure the cell...
    
    cell.textLabel.text = [ma.time descriptionWithLocale:@"dd/MM/yyyy hh:mm"];*/
    
    NSString *CellIdentifier = @"ReportCell";
    
    if (indexPath.row == 0) {
        CellIdentifier = @"MapItCell";
    } else {
        CellIdentifier = @"ChartItCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

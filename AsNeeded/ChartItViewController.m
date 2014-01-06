//
//  ChartItViewController.m
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "ChartItViewController.h"

#import "AsNeededAppDelegate.h"
#import "User.h"
#import "Medication.h"
#import "MedicationAdministration.h"
#import "AggregateCell.h"


@interface ChartItViewController () {
    AsNeededAppDelegate *appDelegate;
    User *user;
    
    int usesThisWeek;
    int usesThisMonth;
    
    NSArray *medicationAdministations;
}

@end

@implementation ChartItViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    appDelegate = [UIApplication sharedApplication].delegate;
    user = appDelegate.user;
    
    self.title = self.med.name;
    
    //Calculate dates for report
    NSDate *oneWeekAgo = [NSDate dateWithTimeIntervalSinceNow:-604800];
    NSDate *oneMonthAgo = [NSDate dateWithTimeIntervalSinceNow:-2629740];
    usesThisWeek = 0;
    usesThisMonth = 0;
    
    medicationAdministations = self.med.medicationAdministrations.allObjects;
    
    for (MedicationAdministration *admin in self.med.medicationAdministrations) {
        if ([admin.time compare:oneWeekAgo] == NSOrderedDescending) {
            usesThisWeek++;
        }
        
        if ([admin.time compare:oneMonthAgo] == NSOrderedDescending) {
            usesThisMonth++;
        }
    }
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
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Weekly";
    } else if (section == 1) {
        return @"Monthly";
    }
    
    return @"Usage Listing";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
     //[(NSArray *)([medicationAdministrations objectForKey:[[medications objectAtIndex:section] name]]) count];
    
    if (section < 2) {
        return 1;
    }
    
    return medicationAdministations.count;
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
    
    if (indexPath.section < 2) {
        CellIdentifier = @"AggregateCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        AggregateCell *agCell = (AggregateCell *)cell;
        agCell.caption.text = [NSString stringWithFormat:@"%i Uses This Week", usesThisWeek];
    } else if (indexPath.section == 1) {
        AggregateCell *agCell = (AggregateCell *)cell;
        agCell.caption.text = [NSString stringWithFormat:@"%i Uses This Month", usesThisMonth];
    } else {
        MedicationAdministration *ma = [medicationAdministations objectAtIndex:indexPath.row];
        cell.textLabel.text = [ma.time descriptionWithLocale:@"dd/MM/yyyy hh:mm"];
    }
    
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

@end

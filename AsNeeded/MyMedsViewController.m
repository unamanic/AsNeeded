//
//  MyMedsViewController.m
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import "MyMedsViewController.h"
#import "User.h"
#import "Medication.h"
#import "AsNeededAppDelegate.h"
#import "EditMedsViewController.h"
#import "MyMedsTableViewCell.h"
#import "MedicationAdministration.h"
#import <iAd/iAd.h>


@interface MyMedsViewController () {
    User *user;
    NSMutableArray *medArray;
    AsNeededAppDelegate *appDelegate;
    Medication *med;
    
    NSTimer* timer;
}

@end

@implementation MyMedsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    user = appDelegate.user;
    medArray = [NSMutableArray arrayWithArray:[user.medications allObjects]];
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self selector:@selector(refreshTable)
                                                    userInfo:nil repeats:YES];
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)viewWillAppear:(BOOL)animated
{
    user = [appDelegate fetchUser];
    if (user) {
        medArray = [NSMutableArray arrayWithArray:[user.medications allObjects]];
        [self.tableView reloadData];
        [self.tableView setNeedsDisplay];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
}

- (void)refreshTable
{
    [self.tableView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    adViewHeightConstraint.constant = adView.bounds.size.height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return medArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMedsTableViewCell *cell;
    if (indexPath.row < medArray.count) {
        
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm:ss"];
        
        Medication *cellMed =[medArray objectAtIndex:indexPath.row];
        // Configure the cell...
        cell.med = cellMed;
        cell.medLabel.text = cellMed.name;
        
        NSTimeInterval remaining = 0;
        
        
        for (MedicationAdministration *admin in cellMed.medicationAdministrations) {
            NSDate *nextDose = [admin.time dateByAddingTimeInterval:[cellMed.minimumTimeBetweenDoses doubleValue]];
            //deterine if the nextdose is later than NOW
            if ([nextDose compare:[NSDate date]] == NSOrderedDescending) {
                remaining = [nextDose timeIntervalSinceNow];
                cell.takeMedButton.enabled = NO;
                cell.intervalProgress.progress = 1+((float)([admin.time timeIntervalSinceNow])/((float)[cellMed.minimumTimeBetweenDoses doubleValue]));
                
                break;
            }
        }
        
        if (remaining) {
            cell.intervalLabel.text = [NSString stringWithFormat:@"Next Dose: %@", [self stringFromTimeInterval:remaining]];
        } else {
            cell.intervalLabel.text = [NSString stringWithFormat:@"Dose Every: %@", [self stringFromTimeInterval:[cellMed.minimumTimeBetweenDoses doubleValue]]];
            cell.takeMedButton.enabled = YES;
            cell.intervalProgress.progress = 0;
        }
    } else {
        static NSString *CellIdentifier = @"AddCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row < medArray.count) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [timer invalidate];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if (indexPath.row < medArray.count) {
            [appDelegate deleteMedication:[medArray objectAtIndex:indexPath.row]];
            [medArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }

    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    

}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshTable)
                                           userInfo:nil repeats:YES];
}


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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (((UIView *)sender).tag == 99) {
        med = nil;
    } else {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        med = [medArray objectAtIndex:indexPath.row];
    }
    EditMedsViewController *desinationVC = [segue destinationViewController];
    desinationVC.med = med;
    
}



- (IBAction)addMed:(id)sender {
    
}

#pragma mark - Clean Up

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  MedMinderViewController.m
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <iAd/iAd.h>
#import "AsNeededViewController.h"
#import "User.h"
#import "Medication.h"
#import "MedicationAdministration.h"
#import "AsNeededAppDelegate.h"
#import "MyMedsCollectionViewCell.h"


@interface AsNeededViewController () {
    AsNeededAppDelegate *appDelegate;
    NSMutableArray *medArray;
    NSTimer *timer;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end


@implementation AsNeededViewController

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
//    [super viewDidLoad];
//    
//    MedMinderAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    user = [appDelegate fetchUser];
//    if (user) {
//        myMedsButton.enabled = YES;
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData)
                                                 name:@"SomethingChanged"
                                               object:[[UIApplication sharedApplication] delegate]];
}

- (void)viewDidAppear:(BOOL)animated
{
    appDelegate = [UIApplication sharedApplication].delegate;
    user = [appDelegate fetchUser];

    
    timer = [NSTimer scheduledTimerWithTimeInterval:5
                                             target:self selector:@selector(refreshCollection)
                                           userInfo:nil repeats:YES];
    
    [self loadData];
}
                                                                            
- (void)loadData
{
    user = [appDelegate fetchUser];
    if (user) {
        myMedsButton.enabled = YES;
        reportsButton.enabled = YES;
        medArray = [NSMutableArray arrayWithArray:[user.medications allObjects]];
    }
    [self refreshCollection];

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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    adViewHeightConstraint.constant = adView.bounds.size.height;
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02i:%02i", hours, minutes];
}

- (void)refreshCollection
{
        user = [appDelegate fetchUser];
    if (user) {
        myMedsButton.enabled = YES;
        reportsButton.enabled = YES;
        medArray = [NSMutableArray arrayWithArray:[user.medications allObjects]];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Methodods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (medArray) {
        return medArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyMedsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MedCell" forIndexPath:indexPath];
    
    Medication *med = [medArray objectAtIndex:indexPath.row];
    
    cell.med = med;
    cell.medLabel.text = med.name;
    
    NSTimeInterval remaining = 0;
    NSDate *adminTime;
    
    
    for (MedicationAdministration *admin in med.medicationAdministrations) {
        NSDate *nextDose = [admin.time dateByAddingTimeInterval:[med.minimumTimeBetweenDoses doubleValue]];
        //deterine if the nextdose is later than NOW
        if ([nextDose compare:[NSDate date]] == NSOrderedDescending) {
            remaining = [nextDose timeIntervalSinceNow];
            adminTime = admin.time;
            cell.button.enabled = NO;
            break;
        }
    }
    
    if (remaining) {
        cell.intervalLabel.text = [NSString stringWithFormat:@"%@", [self stringFromTimeInterval:remaining]];
        [cell.intervalProgress setProgress:1+((float)([adminTime timeIntervalSinceNow])/((float)[med.minimumTimeBetweenDoses doubleValue])) animated:NO];
        [cell.intervalProgress setHidden:NO];

    } else {
        cell.intervalLabel.text = @"Ready!";
        cell.button.enabled = YES;
        //[cell.intervalProgress setProgress:0 animated:NO];
        [cell.intervalProgress setHidden:YES];
    }
    
    return cell;
}

- (IBAction)takeMed:(id)sender {
}

#pragma mark - Clean Up

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

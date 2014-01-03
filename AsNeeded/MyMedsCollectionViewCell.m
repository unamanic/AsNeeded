//
//  MyMedsCollectionViewCell.m
//  AsNeeded
//
//  Created by William Witt on 1/3/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "MyMedsCollectionViewCell.h"

#import "AsNeededAppDelegate.h"
#import "Medication.h"
#import "MedicationAdministration.h"

@implementation MyMedsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)takeMed:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Administer Dose" message:[NSString stringWithFormat:@"Did you take your %@?", self.med.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        appDelegate = [UIApplication sharedApplication].delegate;
        
        MedicationAdministration *admin = [appDelegate createMedicationAdministration];
        admin.medication = self.med;
        admin.time = [NSDate date];
        admin.quantity = [NSNumber numberWithInt:1];
        [appDelegate persistMedicationAdministration:admin];
        self.button.enabled = NO;
        self.intervalLabel.text = @"Calulating";
    }
}
@end

//
//  MyMedsTableViewCell.m
//  AsNeeded
//
//  Created by William Witt on 1/2/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "MyMedsTableViewCell.h"
#import "Medication.h"
#import "MedicationAdministration.h"
#import "AsNeededAppDelegate.h"

@interface MyMedsTableViewCell(){
    AsNeededAppDelegate *appDelegate;
}

@end

@implementation MyMedsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
    }
}
@end

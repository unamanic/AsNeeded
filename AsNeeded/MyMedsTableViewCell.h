//
//  MyMedsTableViewCell.h
//  AsNeeded
//
//  Created by William Witt on 1/2/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;
@class MedicationAdministration;

@interface MyMedsTableViewCell : UITableViewCell <UIAlertViewDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UILabel *medLabel;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *intervalProgress;
@property (weak, nonatomic) IBOutlet UIButton *takeMedButton;

@property (weak, nonatomic) Medication *med;

- (IBAction)takeMed:(id)sender;

@end

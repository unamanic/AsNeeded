//
//  MyMedsCollectionViewCell.h
//  AsNeeded
//
//  Created by William Witt on 1/3/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;
@class AsNeededAppDelegate;

@interface MyMedsCollectionViewCell : UICollectionViewCell {
    AsNeededAppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *medLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *intervalProgress;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;

@property (strong, nonatomic) Medication *med;
- (IBAction)takeMed:(id)sender;

@end

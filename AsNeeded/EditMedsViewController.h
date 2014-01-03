//
//  EditMedsViewController.h
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;

@interface EditMedsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    NSString *name;
    float dosageSize;
    NSString *dosageUnit;
    NSDate *minimumTimeBetweenDoses;
    NSArray *dosageUnitArray;
    UITextField *activeField;

        
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *dosageSizeTextField;
    __weak IBOutlet UIPickerView *dosageUnitTypePicker;
    __weak IBOutlet UIDatePicker *minimumTimePicker;
    __weak IBOutlet UIBarButtonItem *saveButton;
}
@property (strong) Medication *med;

- (IBAction)Save:(id)sender;
- (IBAction)textFieldEdited:(id)sender;
@end

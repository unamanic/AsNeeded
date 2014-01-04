//
//  EditMedsViewController.m
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import "EditMedsViewController.h"
#import "Medication.h"
#import "AsNeededAppDelegate.h"

@interface EditMedsViewController () {
    AsNeededAppDelegate *appDelegate;
}

@end

@implementation EditMedsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    //Temporarily always creating new med
    appDelegate = [UIApplication sharedApplication].delegate;
    //self.med = [appDelegate createMedication];
    //med = appDelegate.med;
    
    dosageUnitArray = [NSArray arrayWithObjects:@"mg",
                       @"Pill",
                       @"Tablespoon",
                       @"Teaspoon",
                       @"ml",
                       @"Puff",
                       @"Injection",
                       @"Other",
                       nil];
    
    int dosageUnitIndex = 0;
    
    NSLog(@"%@", self.med.dosageType);
    
    for (NSString *string in dosageUnitArray) {
        if ([string isEqualToString:self.med.dosageUnit]) {
            dosageUnitIndex = [dosageUnitArray indexOfObject:string];
        }
    }
    if (self.med) {
        nameTextField.text = self.med.name;
        dosageSizeTextField.text = [self.med.dosageSize stringValue];
        [dosageUnitTypePicker selectRow:dosageUnitIndex inComponent:0 animated:YES];
        if (self.med.minimumTimeBetweenDoses ) {
            minimumTimePicker.countDownDuration = [self.med.minimumTimeBetweenDoses doubleValue];
        }
    }
    [self textFieldEdited:nil];
    
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:@"SomethingChanged"
                                               object:[[UIApplication sharedApplication] delegate]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Save:(id)sender {
    
    if (!self.med) {
        self.med = [appDelegate createMedication];
    }
    self.med.name = nameTextField.text;
    self.med.dosageSize = [NSNumber numberWithFloat:dosageSizeTextField.text.floatValue];
    self.med.dosageUnit = dosageUnit;
    self.med.minimumTimeBetweenDoses = [NSNumber numberWithDouble:minimumTimePicker.countDownDuration];
    appDelegate.med = self.med;
    [appDelegate persistMedication:self.med];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)textFieldEdited:(id)sender {
    if (nameTextField.text.length > 0 && dosageSizeTextField.text.floatValue > 0) {
        saveButton.enabled = YES;
    } else {
        saveButton.enabled = NO;
    }
}
#pragma mark - UIPickerViewDatasource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dosageUnitArray count];
}

#pragma mark - UIPickerViewDelegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dosageUnitArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    dosageUnit = [dosageUnitArray objectAtIndex:row];
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard Shit

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (kbSize.width < kbSize.height)
    {
        // NOTE: fixing iOS bug: http://stackoverflow.com/questions/9746417/keyboard-willshow-and-//willhide-vs-rotation
        CGFloat height = kbSize.height;
        kbSize.height = kbSize.width;
        kbSize.width = height;
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = activeField.frame.origin;
    origin.y -= scrollView.contentOffset.y;
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-(aRect.size.height));
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    scrollView.scrollEnabled = YES;
}

@end

//
//  MyInfoViewController.m
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import "MyInfoViewController.h"
#import "AsNeededAppDelegate.h"
#import "User.h"

@interface MyInfoViewController () {
    UITextField *activeField;
    
    UIEdgeInsets scrollviewInsets;
}

@end

@implementation MyInfoViewController

UIGestureRecognizer *tapper;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    
    //tapper = [[UITapGestureRecognizer alloc]
    //          initWithTarget:self action:@selector(handleSingleTap:)];
    //tapper.cancelsTouchesInView = NO;
    //[self.view addGestureRecognizer:tapper];
	
    AsNeededAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    user = appDelegate.user;
    if (!user) {
        user = [appDelegate fetchOrCreateUser];
        [self.navigationItem setHidesBackButton:YES];
    } else {
        nameTextField.text = user.name;
        
        if ([user.gender  isEqual: @"Male"]) {
            [genderButton setSelectedSegmentIndex:0];
        } else {
            [genderButton setSelectedSegmentIndex:1];
        }
        birthdatPicker.date = user.birthDate;
        
        phoneTextbox.text = user.phoneNumber;
        
        addressTextbox.text = user.address;
        
        cityTextbox.text = user.city;
        
        stateTextbox.text = user.state;
        
        zipTextbox.text = user.zip;
        
        scrollviewInsets = scrollView.contentInset;
    }
    nameTextField.delegate = self;
    phoneTextbox.delegate = self;
    addressTextbox.delegate = self;
    cityTextbox.delegate = self;
    stateTextbox.delegate = self;
    zipTextbox.delegate = self;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    AsNeededAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    user.name = nameTextField.text;
    if (genderButton.selectedSegmentIndex == 0) {
        user.gender = @"Male";
    } else {
        user.gender = @"Female";
    }
    user.birthDate = birthdatPicker.date;
    [appDelegate persistUser:user];
    
    user.phoneNumber = phoneTextbox.text;
    user.address = addressTextbox.text;
    user.city = cityTextbox.text;
    user.state = stateTextbox.text;
    user.zip = zipTextbox.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeKeyboard:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}

- (IBAction)nameTextFiledDidChange:(id)sender {
    if (nameTextField.text.length > 0) {
        saveButton.enabled = YES;
    } else {
        saveButton.enabled = NO;
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([nameTextField.text  isEqual: @""]) {
        saveButton.enabled = NO;
    } else {
        saveButton.enabled = YES;
    }
    activeField = nil;
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

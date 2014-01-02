//
//  MyInfoViewController.h
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface MyInfoViewController : UIViewController <UITextFieldDelegate, UITextFieldDelegate> {
    User * user;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UISegmentedControl *genderButton;
    __weak IBOutlet UIDatePicker *birthdatPicker;
    __weak IBOutlet UITextField *addressTextbox;
    __weak IBOutlet UITextField *cityTextbox;
    __weak IBOutlet UITextField *stateTextbox;
    __weak IBOutlet UITextField *zipTextbox;
    __weak IBOutlet UITextField *phoneTextbox;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIBarButtonItem *saveButton;
}

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
- (IBAction)save:(id)sender;
- (IBAction)removeKeyboard:(id)sender;
- (IBAction)nameTextFiledDidChange:(id)sender;
@end

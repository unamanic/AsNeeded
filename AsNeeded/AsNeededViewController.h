//
//  MedMinderViewController.h
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class User;

@interface AsNeededViewController : UIViewController {
    User * user;
    __weak IBOutlet UIButton *myMedsButton;
    __weak IBOutlet UIButton *reportsButton;
    __weak IBOutlet UIButton *myInfoButton;
}


@end
//
//  MyMedsViewController.h
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADBannerView;

@interface MyMedsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UIBarButtonItem *addButton;
    __weak IBOutlet ADBannerView *adView;
    
    __weak IBOutlet NSLayoutConstraint *adViewHeightConstraint;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addMed:(id)sender;
@end

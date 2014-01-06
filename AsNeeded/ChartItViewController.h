//
//  ChartItViewController.h
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;

@interface ChartItViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Medication *med;

@property (weak, nonatomic) IBOutlet UIImageView *chart;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

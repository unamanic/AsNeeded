//
//  MedMinderViewController.m
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import "AsNeededViewController.h"
#import "User.h"
#import "AsNeededAppDelegate.h"

@interface AsNeededViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end


@implementation AsNeededViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    [super viewDidLoad];
//    
//    MedMinderAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    user = [appDelegate fetchUser];
//    if (user) {
//        myMedsButton.enabled = YES;
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    AsNeededAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    user = [appDelegate fetchUser];
    if (user) {
        myMedsButton.enabled = YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

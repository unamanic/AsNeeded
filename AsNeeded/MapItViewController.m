//
//  MapItViewController.m
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "MapItViewController.h"
#import "AsNeededAppDelegate.h"

#import "User.h"
#import "Medication.h"
#import "MedicationAdministration.h"

@interface MapItViewController () {
    AsNeededAppDelegate *appDelegate;
    User *user;
}

@end

@implementation MapItViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appDelegate = [UIApplication sharedApplication].delegate;
    user = appDelegate.user;

    self.mapView.mapType = MKMapTypeHybrid;
    
    if (![user.zip  isEqual: @""]) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:user.zip completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                self.mapView.centerCoordinate = aPlacemark.location.coordinate;

            }
        }];
    } else {
        self.mapView.centerCoordinate = appDelegate.location.coordinate;
    }
    
    MKCoordinateRegion region = [self.mapView regionThatFits:MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(0.5, 0.5))];
    self.mapView.region = region;
    self.mapView.showsUserLocation = YES;
    
    for(MedicationAdministration *admin in self.med.medicationAdministrations){
        if (admin.lat && admin.lon) {
            MKPlacemark *adminLocation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([admin.lat doubleValue], [admin.lon doubleValue]) addressDictionary:nil];
            [self.mapView addAnnotation:adminLocation];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

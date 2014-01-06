//
//  MapItViewController.h
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Medication;

@interface MapItViewController : UIViewController

@property (strong, nonatomic) Medication *med;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

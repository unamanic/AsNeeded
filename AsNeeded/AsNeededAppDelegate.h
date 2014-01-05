//
//  MedMinderAppDelegate.h
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class User;
@class Medication;
@class MedicationAdministration;

@interface AsNeededAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate> {

}
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Medication *med;
@property (strong, nonatomic) MedicationAdministration *medAdmin;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;



@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (User *)fetchUser;
- (void)persistUser:(User *)userIn;
- (User *)fetchOrCreateUser;

- (Medication *)createMedication;
- (void)persistMedication:(Medication *)medicationIn;
- (void)deleteMedication:(Medication *)medicationIn;

- (MedicationAdministration *)createMedicationAdministration;
- (void)persistMedicationAdministration:(MedicationAdministration *)medAdminIn;
@end

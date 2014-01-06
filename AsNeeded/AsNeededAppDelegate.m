//
//  MedMinderAppDelegate.m
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//


#import "AsNeededAppDelegate.h"
#import "User.h"
#import "Medication.h"

@interface AsNeededAppDelegate() {
}

@end

@implementation AsNeededAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 500; //meters
    [_locationManager startUpdatingLocation];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [_locationManager stopUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [_locationManager stopUpdatingLocation];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [_locationManager startUpdatingLocation];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [_locationManager startUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AsNeeded" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSPersistentStoreCoordinator *psc = _persistentStoreCoordinator;
    
    NSError *localError = nil;
    NSDictionary *iCloudOptions = nil;
    NSString *iCloudStorePath = [[[self applicationDocumentsDirectory] path]stringByAppendingPathComponent:@"AsNeeded.sqlite"];
    NSURL *iCloudStoreUrl = [NSURL fileURLWithPath:iCloudStorePath];
    
    //  The API to turn on Core Data iCloud support here.
    iCloudOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"iCloudStore", NSPersistentStoreUbiquitousContentNameKey,
                     [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                     [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    [psc addPersistentStoreWithType:NSSQLiteStoreType
                                     configuration:nil
                                               URL:iCloudStoreUrl
                                           options:iCloudOptions
                                             error:&localError];


    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:coordinator];
        }];
        _managedObjectContext = moc;
    }
    
    return _managedObjectContext;
}

- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
    
	NSLog(@"Merging in changes from iCloud...");
    
    NSNotification* refreshNotification = [NSNotification
                                           notificationWithName:@"SomethingChanged"
                                           object:self
                                           userInfo:[notification userInfo]];
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't persist");
    }
    [self.managedObjectContext reset];

    [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];

}
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - PersistanceMethods

- (User *)fetchUser
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *fetchedRecords = [self.managedObjectContext
                               executeFetchRequest:fetchRequest
                               error:&error];
    if (fetchedRecords && [fetchedRecords count] >= 1) {
        self.user = [fetchedRecords objectAtIndex:0];
        return self.user;
    }
    return nil;
}

- (void)persistUser:(User *)userIn
{
    self.user = userIn;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't persist the user");
    }
}


- (User *)fetchOrCreateUser
{
    User *user = [self fetchUser];
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    }
    return user;
}

- (Medication *)createMedication
{
    Medication *medication = [NSEntityDescription insertNewObjectForEntityForName:@"Medication" inManagedObjectContext:self.managedObjectContext];
    medication.user = self.user;
    return medication;
}

- (void)persistMedication:(Medication *)medicationIn;
{
    self.med = medicationIn;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't persist the medication");
    }
}

- (void)deleteMedication:(Medication *)medicationIn
{
    [self.managedObjectContext deleteObject:medicationIn];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't persist");
    }
}

- (MedicationAdministration *)createMedicationAdministration
{
    MedicationAdministration *medicationAdmin = [NSEntityDescription insertNewObjectForEntityForName:@"MedicationAdministration" inManagedObjectContext:self.managedObjectContext];
    return medicationAdmin;
}

- (void)persistMedicationAdministration:(MedicationAdministration *)medAdminIn
{
    NSError *error;
    
    self.medAdmin = medAdminIn;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't persist");
    }
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [locations lastObject];
}

@end

//
//  MedMinderAppDelegate.h
//  MedMinder
//
//  Created by William Witt on 12/29/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class Medication;

@interface AsNeededAppDelegate : UIResponder <UIApplicationDelegate> {

}
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Medication *med;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (User *)fetchUser;
- (void)persistUser:(User *)userIn;
- (User *)fetchOrCreateUser;

@end

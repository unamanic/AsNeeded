//
//  Medication.h
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MedicationAdministration, PeriodicAdministrationSchedule, User;

@interface Medication : NSManagedObject

@property (nonatomic, retain) NSNumber * canSpit;
@property (nonatomic, retain) NSNumber * dosageQuantity;
@property (nonatomic, retain) NSNumber * dosageSize;
@property (nonatomic, retain) NSString * dosageType;
@property (nonatomic, retain) NSString * dosageUnit;
@property (nonatomic, retain) NSDate * intraadministrationCooldown;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * minimumTimeBetweenDoses;
@property (nonatomic, retain) NSSet *medicationAdministrations;
@property (nonatomic, retain) NSSet *periodicAdministrationSchedule;
@property (nonatomic, retain) User *user;
@end

@interface Medication (CoreDataGeneratedAccessors)

- (void)addMedicationAdministrationsObject:(MedicationAdministration *)value;
- (void)removeMedicationAdministrationsObject:(MedicationAdministration *)value;
- (void)addMedicationAdministrations:(NSSet *)values;
- (void)removeMedicationAdministrations:(NSSet *)values;

- (void)addPeriodicAdministrationScheduleObject:(PeriodicAdministrationSchedule *)value;
- (void)removePeriodicAdministrationScheduleObject:(PeriodicAdministrationSchedule *)value;
- (void)addPeriodicAdministrationSchedule:(NSSet *)values;
- (void)removePeriodicAdministrationSchedule:(NSSet *)values;

@end

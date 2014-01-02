//
//  PeriodicAdministrationSchedule.h
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medication, PeriodicAdministrationOccurance;

@interface PeriodicAdministrationSchedule : NSManagedObject

@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSNumber * reminder;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) NSSet *periodicAdministrationOcurrances;
@end

@interface PeriodicAdministrationSchedule (CoreDataGeneratedAccessors)

- (void)addPeriodicAdministrationOcurrancesObject:(PeriodicAdministrationOccurance *)value;
- (void)removePeriodicAdministrationOcurrancesObject:(PeriodicAdministrationOccurance *)value;
- (void)addPeriodicAdministrationOcurrances:(NSSet *)values;
- (void)removePeriodicAdministrationOcurrances:(NSSet *)values;

@end

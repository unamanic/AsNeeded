//
//  PeriodicAdministrationOccurance.h
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PeriodicAdministrationSchedule;

@interface PeriodicAdministrationOccurance : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeFromStart;
@property (nonatomic, retain) PeriodicAdministrationSchedule *periodicAdministrationSchedule;

@end

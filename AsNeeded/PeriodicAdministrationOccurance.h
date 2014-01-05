//
//  PeriodicAdministrationOccurance.h
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PeriodicAdministrationSchedule;

@interface PeriodicAdministrationOccurance : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeFromStart;
@property (nonatomic, retain) PeriodicAdministrationSchedule *periodicAdministrationSchedule;

@end

//
//  Medication.m
//  AsNeeded
//
//  Created by William Witt on 1/2/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "Medication.h"
#import "MedicationAdministration.h"
#import "PeriodicAdministrationSchedule.h"
#import "User.h"


@implementation Medication

@dynamic canSpit;
@dynamic dosageQuantity;
@dynamic dosageSize;
@dynamic dosageType;
@dynamic dosageUnit;
@dynamic intraadministrationCooldown;
@dynamic minimumTimeBetweenDoses;
@dynamic name;
@dynamic medicationAdministrations;
@dynamic periodicAdministrationSchedule;
@dynamic user;

@end

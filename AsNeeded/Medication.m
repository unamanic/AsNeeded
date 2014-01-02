//
//  Medication.m
//  AsNeeded
//
//  Created by William Witt on 12/30/13.
//  Copyright (c) 2013 William Witt. All rights reserved.
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
@dynamic name;
@dynamic minimumTimeBetweenDoses;
@dynamic medicationAdministrations;
@dynamic periodicAdministrationSchedule;
@dynamic user;

@end

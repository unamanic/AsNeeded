//
//  User.h
//  AsNeeded
//
//  Created by William Witt on 1/5/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medication;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSSet *medications;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMedicationsObject:(Medication *)value;
- (void)removeMedicationsObject:(Medication *)value;
- (void)addMedications:(NSSet *)values;
- (void)removeMedications:(NSSet *)values;

@end

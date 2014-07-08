//
// Created by azu on 2014/07/08.
//


#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface ViewModel : NSObject
@property(nonatomic, strong) NSNumber *heightData;

@property(nonatomic, strong) NSDate *recordDate;

- (HKQuantitySample *)heightSample;

// return HKQuantityType which is used by this app
- (HKQuantityType *)managedType;
@end
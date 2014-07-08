//
// Created by azu on 2014/07/09.
//


#import <Foundation/Foundation.h>

@class PMKPromise;

#import <HealthKit/HealthKit.h>

@interface DataStoreManager : NSObject
@property(nonatomic, strong) HKHealthStore *healthStore;

- (PMKPromise *)authorizationToType:(HKQuantityType *) hkQuantity;
- (PMKPromise *)writeSample:(HKQuantitySample *)sample;
@end
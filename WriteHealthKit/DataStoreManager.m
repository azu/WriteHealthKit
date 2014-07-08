//
// Created by azu on 2014/07/09.
//


#import <PromiseKit/Promise.h>
#import "DataStoreManager.h"


@implementation DataStoreManager {

}
- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    // long life object
    _healthStore = [[HKHealthStore alloc] init];

    return self;
}

- (PMKPromise *)authorizationToType:(HKQuantityType *) quantityType {
    NSSet *dataTypes = [NSSet setWithObject:quantityType];
    // authorization for write / read
    return [PMKPromise new:^(PMKPromiseFulfiller fulfiller, PMKPromiseRejecter rejecter) {
        [self.healthStore requestAuthorizationToShareTypes:dataTypes readTypes:dataTypes completion:^(BOOL success, NSError *error) {
            if (!error) {
                fulfiller(nil);
            } else {
                rejecter(error);
            }
        }];
    }];
}

// HKQuantitySample is child of HKObject
- (PMKPromise *)writeSample:(HKQuantitySample *) sample {
    return [PMKPromise new:^(PMKPromiseFulfiller fulfiller, PMKPromiseRejecter rejecter) {
        [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
            if (!error) {
                fulfiller(nil);
            } else {
                rejecter(error);
            }
        }];
    }];
}


@end
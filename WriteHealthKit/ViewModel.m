//
// Created by azu on 2014/07/08.
//


#import "ViewModel.h"
#import "Promise.h"
#import "DataStoreManager.h"


@implementation ViewModel {

}
- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _recordDate = [NSDate date];
    return self;
}

- (HKQuantitySample *)heightSample {
    if (self.heightData == nil) {
        return nil;
    }
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    // double/cm
    double meterValue = self.heightData.doubleValue / 100;
    HKQuantity *height = [HKQuantity quantityWithUnit:[HKUnit meterUnit] doubleValue:meterValue];
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:height startDate:self.recordDate endDate:self.recordDate];
    return heightSample;
}

- (HKQuantityType *)managedType {
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    return heightType;
}

@end
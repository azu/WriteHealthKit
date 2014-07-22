# WriteHealthKit

Example project for HealthKit

* use [PromiseKit](http://promisekit.org/ "PromiseKit")
* write data

A Series of HealthKit Demo.

* [azu/ReadHealthKit](https://github.com/azu/ReadHealthKit "azu/ReadHealthKit")
* [azu/WriteHealthKit](https://github.com/azu/WriteHealthKit "azu/WriteHealthKit")
* [azu/StatisticsHealthKit](https://github.com/azu/StatisticsHealthKit "azu/StatisticsHealthKit")

## Installation

```sh
pod install
```

## Usage

1. Input data
2. Save data


### API Design

Promise wrapper of `HKHealthStore`.

```objc
@interface DataStoreManager : NSObject
@property(nonatomic, strong) HKHealthStore *healthStore;
// authorizationToType + authorizationStatusForType
- (PMKPromise *)availableType:(HKQuantityType *) hkQuantity;

- (PMKPromise *)authorizationToType:(HKQuantityType *) hkQuantity;

- (PMKPromise *)authorizationStatusForType:(HKQuantityType *) quantityType;

- (PMKPromise *)writeSample:(HKQuantitySample *)sample;
@end
```

Smart control flow by used that.

``` objc
PMKPromise *availableTypePromise = [self.dataStoreManager availableType:self.model.managedType];
availableTypePromise.then(^{
    return [self.dataStoreManager writeSample:self.model.heightSample];
}).then(^{
    UIAlertView *savedAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [savedAlert show];
}).catch(^(NSError *error) {
    UIAlertView *savedAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [savedAlert show];
    NSLog(@"error = %@", error);
});
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

MIT

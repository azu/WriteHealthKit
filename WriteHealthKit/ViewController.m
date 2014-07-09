//
//  ViewController.m
//  WriteHealthKit
//
//  Created by azu on 2014/07/08.
//  Copyright (c) 2014年 azu. All rights reserved.
//

#import <PromiseKit/Promise.h>
#import "ViewController.h"
#import "ViewModel.h"
#import "DataStoreManager.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UITextField *heightTextField;
@property(weak, nonatomic) IBOutlet UILabel *samplePreviewLabel;
@property(weak, nonatomic) IBOutlet UIDatePicker *datePicker;
// model
@property(nonatomic, strong) DataStoreManager *dataStoreManager;
@property(nonatomic, strong) ViewModel *model;

- (IBAction)handleTextChanged:(id) sender;

- (IBAction)handleSaveButton:(id) sender;

- (IBAction)handleDateChanged:(id) sender;

@end

@implementation ViewController
- (ViewModel *)model {
    if (_model == nil) {
        _model = [[ViewModel alloc] init];
    }
    return _model;
}

- (DataStoreManager *)dataStoreManager {
    if (_dataStoreManager == nil) {
        _dataStoreManager = [[DataStoreManager alloc] init];
    }
    return _dataStoreManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updatePreview {
    self.samplePreviewLabel.text = [self.model.heightSample description];
}

- (IBAction)handleTextChanged:(UITextField *) sender {
    self.model.heightData = @([sender.text doubleValue]);
    [self updatePreview];
}

- (IBAction)handleDateChanged:(UIDatePicker *) sender {
    self.model.recordDate = sender.date;
    [self updatePreview];
}

- (IBAction)handleSaveButton:(id) sender {
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
}

@end

//
//  MagnetometerViewController.m
//  Sensors
//
//  Created by Carlos on 19/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "MagnetometerViewController.h"
#import "AppDelegate.h"

@implementation MagnetometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager headingAvailable]) {
        NSLog(@"Magnetometer available!");
        
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusRestricted:
                /*
                 * This application is not authorized to use location services. 
                 * The user cannot change this application’s status, 
                 * possibly due to active restrictions such as parental controls.
                 */
            case kCLAuthorizationStatusDenied:
                /*
                 * The user explicitly denied the use of location services 
                 * for this application or location services are currently disabled in Settings.
                 */
                NSLog(@"Magnetometer cannot be used!");
                break;
            case kCLAuthorizationStatusNotDetermined:
                /*
                 * The user has not yet made a choice regarding
                 * whether this application can use location services.
                 */
            case kCLAuthorizationStatusAuthorized:
                /*
                 * This application is authorized to use location services.
                 */
                locationManager.delegate = self;
                [locationManager startUpdatingHeading];
                break;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [locationManager stopUpdatingHeading];
}

#pragma mark - CLLocation Manager Delegate Methods

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    CLLocationDirection accuracy = newHeading.headingAccuracy;
    if (accuracy == -1) {
        headingLbl.text = @"Invalid";
    } else {
        headingLbl.text = [NSString stringWithFormat:@"%f", newHeading.magneticHeading];
    }
    accuracyLbl.text = [NSString stringWithFormat:@"%f", accuracy];
}

@end

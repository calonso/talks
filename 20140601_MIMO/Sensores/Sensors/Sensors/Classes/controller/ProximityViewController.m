//
//  ProximityViewController.m
//  Sensors
//
//  Created by Carlos on 29/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "ProximityViewController.h"

@implementation ProximityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    if (device.proximityMonitoringEnabled == YES) {
        // This is implicit testing of hardware availability.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    } else {
        NSLog(@"Proximity sensor not available!");
    }
}

- (void) proximityChanged:(NSNotification *)notification {
    UIDevice *device = [notification object];
    NSLog(@"In proximity: %d", device.proximityState);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
}

@end

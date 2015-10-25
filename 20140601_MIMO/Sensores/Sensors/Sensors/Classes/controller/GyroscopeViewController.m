//
//  GyroscopeViewController.m
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "GyroscopeViewController.h"
#import "AppDelegate.h"

@implementation GyroscopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Get the singleton
    motionManager = [AppDelegate sharedManager];
    // Test availability
    if ([motionManager isDeviceMotionAvailable]){
        // If available
        if (![motionManager isDeviceMotionActive]){
            // And NOT active
            NSOperationQueue *queue = [NSOperationQueue currentQueue];
            [motionManager startDeviceMotionUpdatesToQueue:queue withHandler:
             ^(CMDeviceMotion *deviceMotion, NSError *error) {
                 xLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.rotationRate.x];
                 yLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.rotationRate.y];
                 zLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.rotationRate.z];
                 
                 /* Setup low-pass filter variables */
                 static CGFloat x0 = 0;
                 static CGFloat y0 = 0;
                 static CGFloat z0 = 0;
                 
                 NSTimeInterval const dt = UPDATE_FREQUENCY;
                 const double RC = 0.3;
                 const double alpha = dt / (RC + dt);
                 
                 CMRotationRate filteredRot;
                 filteredRot.x = (alpha * deviceMotion.rotationRate.x) + (1.0 - alpha) * x0;
                 filteredRot.y = (alpha * deviceMotion.rotationRate.y) + (1.0 - alpha) * y0;
                 filteredRot.z = (alpha * deviceMotion.rotationRate.z) + (1.0 - alpha) * z0;
                 
                 fxLbl.text = [NSString stringWithFormat:@"%.03f", filteredRot.x];
                 fyLbl.text = [NSString stringWithFormat:@"%.03f", filteredRot.y];
                 fzLbl.text = [NSString stringWithFormat:@"%.03f", filteredRot.z];
                 
                 roll.text = [NSString stringWithFormat:@"%.03f", deviceMotion.attitude.roll];
                 pitch.text = [NSString stringWithFormat:@"%.03f", deviceMotion.attitude.pitch];
                 yaw.text = [NSString stringWithFormat:@"%.03f", deviceMotion.attitude.yaw];
             }];
        } else {
            NSLog(@"Device motion capture is already active");
        }
    } else{
        NSLog(@"Device motion capture is not available");
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [motionManager stopDeviceMotionUpdates];
}

@end

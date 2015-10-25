//
//  AccelerometerViewController.m
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "AccelerometerViewController.h"
#import "AppDelegate.h"

@implementation AccelerometerViewController 

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
                 xLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.userAcceleration.x];
                 yLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.userAcceleration.y];
                 zLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.userAcceleration.z];
                 
                 /* Setup low-pass filter variables */
                 static CGFloat x0 = 0;
                 static CGFloat y0 = 0;
                 static CGFloat z0 = 0;
                 
                 NSTimeInterval const dt = UPDATE_FREQUENCY;
                 const double RC = 0.3;
                 const double alpha = dt / (RC + dt);
                 
                 CMAcceleration filteredAcc;
                 filteredAcc.x = (alpha * deviceMotion.userAcceleration.x) + (1.0 - alpha) * x0;
                 filteredAcc.y = (alpha * deviceMotion.userAcceleration.y) + (1.0 - alpha) * y0;
                 filteredAcc.z = (alpha * deviceMotion.userAcceleration.z) + (1.0 - alpha) * z0;

                 fxLbl.text = [NSString stringWithFormat:@"%.03f", filteredAcc.x];
                 fyLbl.text = [NSString stringWithFormat:@"%.03f", filteredAcc.y];
                 fzLbl.text = [NSString stringWithFormat:@"%.03f", filteredAcc.z];
                 
                 x0 = filteredAcc.x;
                 y0 = filteredAcc.y;
                 z0 = filteredAcc.z;
                 
                 grXLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.gravity.x];
                 grYLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.gravity.y];
                 grZLbl.text = [NSString stringWithFormat:@"%.03f", deviceMotion.gravity.z];
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

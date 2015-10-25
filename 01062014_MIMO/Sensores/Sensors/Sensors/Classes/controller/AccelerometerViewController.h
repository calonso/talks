//
//  AccelerometerViewController.h
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AccelerometerViewController : UIViewController {
    // User Acceleration labels
    IBOutlet UILabel *xLbl;
    IBOutlet UILabel *yLbl;
    IBOutlet UILabel *zLbl;
    
    // Filtered User Acceleration labels
    IBOutlet UILabel *fxLbl;
    IBOutlet UILabel *fyLbl;
    IBOutlet UILabel *fzLbl;

    // Gravity labels
    IBOutlet UILabel *grXLbl;
    IBOutlet UILabel *grYLbl;
    IBOutlet UILabel *grZLbl;
    
    CMMotionManager *motionManager;
}

@end

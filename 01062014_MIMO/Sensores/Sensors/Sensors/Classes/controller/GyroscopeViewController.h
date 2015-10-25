//
//  GyroscopeViewController.h
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GyroscopeViewController : UIViewController {
    IBOutlet UILabel *xLbl;
    IBOutlet UILabel *yLbl;
    IBOutlet UILabel *zLbl;
    
    IBOutlet UILabel *fxLbl;
    IBOutlet UILabel *fyLbl;
    IBOutlet UILabel *fzLbl;
    
    IBOutlet UILabel *roll;
    IBOutlet UILabel *pitch;
    IBOutlet UILabel *yaw;
    
    CMMotionManager *motionManager;
}

@end

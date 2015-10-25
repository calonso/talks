//
//  MagnetometerViewController.h
//  Sensors
//
//  Created by Carlos on 19/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface MagnetometerViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UILabel *headingLbl;
    IBOutlet UILabel *accuracyLbl;
    
    CLLocationManager *locationManager;
}

@end

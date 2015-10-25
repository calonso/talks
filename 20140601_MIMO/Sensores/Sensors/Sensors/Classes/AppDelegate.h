//
//  AppDelegate.h
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

extern NSTimeInterval const UPDATE_FREQUENCY;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (CMMotionManager *)sharedManager;

@end

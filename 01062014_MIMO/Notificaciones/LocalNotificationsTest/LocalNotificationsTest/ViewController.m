//
//  ViewController.m
//  LocalNotificationsTest
//
//  Created by Carlos on 07/03/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (IBAction)schedule {
    // Instantiate a new UILocalNotification object
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    // Set the time when will fire
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:20];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // Set how will display
    localNotif.alertBody = @"Hola Caracola";
    localNotif.alertAction = @"Mirame";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    // Set it's internal information
    localNotif.userInfo = @{@"secret": [NSNumber numberWithInt:rand()]};
    
    // Schedule, and finally, release it
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end

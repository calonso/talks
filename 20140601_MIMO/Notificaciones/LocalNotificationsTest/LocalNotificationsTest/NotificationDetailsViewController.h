//
//  NotificationDetailsViewController.h
//  LocalNotificationsTest
//
//  Created by Carlos on 11/03/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailsViewController : UIViewController {
    IBOutlet UILabel *label;
}

@property (nonatomic, strong) UILocalNotification *notification;

@end

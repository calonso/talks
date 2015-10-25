//
//  NotificationDetailsViewController.m
//  LocalNotificationsTest
//
//  Created by Carlos on 11/03/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "NotificationDetailsViewController.h"

@interface NotificationDetailsViewController ()

@end

@implementation NotificationDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    label.text = _notification.userInfo.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

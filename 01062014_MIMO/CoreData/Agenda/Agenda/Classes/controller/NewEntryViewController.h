//
//  NewEntryViewController.h
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailsViewController.h"

@interface NewEntryViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *info;
}

@property (nonatomic, strong) UserDetailsViewController *delegate;

@end

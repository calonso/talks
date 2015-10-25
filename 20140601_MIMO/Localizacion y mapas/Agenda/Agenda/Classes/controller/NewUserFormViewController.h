//
//  NewUserFormViewController.h
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserFormViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *surnameTextField;
    IBOutlet UITextField *dniTextField;
    IBOutlet UITextField *addressTextField;
}

@end

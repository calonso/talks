//
//  SearchViewController.h
//  Agenda
//
//  Created by Carlos on 14/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *surnameTextField;
    IBOutlet UITextField *dniTextField;
}

@end

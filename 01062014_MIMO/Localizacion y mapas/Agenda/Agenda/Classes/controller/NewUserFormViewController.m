//
//  NewUserFormViewController.m
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "NewUserFormViewController.h"
#import "Contact.h"
#import "UserDetailsViewController.h"
#import "ModelHelper.h"

@implementation NewUserFormViewController

- (IBAction)save {  
    NSError *error = nil;
    Contact *contact = [Contact create:nameTextField.text :surnameTextField.text
                                      :dniTextField.text :addressTextField.text :&error];
    if (contact) {
        UserDetailsViewController *udvc = [[UserDetailsViewController alloc] init];
        udvc.contact = contact;
        [self.navigationController pushViewController:udvc animated:YES];
    } else {
        [ModelHelper displayValidationError:error];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end

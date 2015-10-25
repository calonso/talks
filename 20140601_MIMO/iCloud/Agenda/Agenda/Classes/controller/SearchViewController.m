//
//  SearchViewController.m
//  Agenda
//
//  Created by Carlos on 14/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"
#import "UsersListViewController.h"
#import "Contact.h"

@implementation SearchViewController

- (IBAction)search {
    NSError *error = nil;
    NSArray *contacts = [Contact query:nameTextField.text :surnameTextField.text :dniTextField.text :&error];
    
    UsersListViewController *ulvc = [[UsersListViewController alloc] init];
    ulvc.contacts = contacts;
    [self.navigationController pushViewController:ulvc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark AgendaController methods

- (void) refreshData {
    
}

@end

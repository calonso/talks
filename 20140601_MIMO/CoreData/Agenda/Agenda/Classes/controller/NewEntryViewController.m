//
//  NewEntryViewController.m
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "NewEntryViewController.h"
#import "ContactInfo.h"

@implementation NewEntryViewController

- (IBAction)addEntry {
    [_delegate addEntryToContact:[ContactInfo build:info.text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end

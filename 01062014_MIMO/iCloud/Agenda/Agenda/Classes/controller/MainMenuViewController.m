//
//  MainMenuViewController.m
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "MainMenuViewController.h"
#import "NewUserFormViewController.h"
#import "UsersListViewController.h"
#import "SearchViewController.h"

@implementation MainMenuViewController

- (IBAction) newUser {
    [self.navigationController pushViewController:[[NewUserFormViewController alloc] init] animated:YES];
}

- (IBAction) list {
    [self.navigationController pushViewController:[[UsersListViewController alloc] init] animated:YES];
}

- (IBAction) search {
    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}

#pragma mark - AgendaController Methods

- (void) refreshData {
    
}

@end

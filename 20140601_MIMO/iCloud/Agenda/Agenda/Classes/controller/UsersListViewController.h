//
//  UsersListViewController.h
//  Agenda
//
//  Created by Carlos on 29/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaController.h"

@interface UsersListViewController : UITableViewController<AgendaController>

@property (nonatomic, strong) NSArray *contacts;

@end

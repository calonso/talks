//
//  UserDetailsViewController.h
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactInfo.h"
#import "AgendaController.h"

@interface UserDetailsViewController : UIViewController <UITableViewDataSource, AgendaController> {
    IBOutlet UITableView *table;
    IBOutlet UILabel *name;
    IBOutlet UILabel *surname;
    IBOutlet UILabel *dni;
    IBOutlet UILabel *address;
    
    NSArray *entries;
}

@property (nonatomic, strong) Contact *contact;

- (void) addEntryToContact:(ContactInfo *)entry;

@end

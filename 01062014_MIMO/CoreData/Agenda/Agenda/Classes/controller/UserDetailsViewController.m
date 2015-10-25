//
//  UserDetailsViewController.m
//  Agenda
//
//  Created by Carlos on 28/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "NewEntryViewController.h"
#import "ModelHelper.h"

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    name.text = _contact.name;
    surname.text = _contact.surname;
    dni.text = _contact.dni;
    address.text = _contact.address;
    entries = [_contact.infoEntries allObjects];
}

- (IBAction) showNewEntryScreen {
    NewEntryViewController *nevc = [[NewEntryViewController alloc] init];
    nevc.delegate = self;
    [self presentModalViewController:nevc animated:YES];
}

- (void) addEntryToContact:(ContactInfo *)entry {
    [_contact addInfoEntriesObject:entry];
    
    NSError *error = nil;
    if ([ModelHelper saveContext:&error]) {
        entries = [_contact.infoEntries allObjects];
        [table reloadData];
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"An error occurred saving the info"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]
         show];
    }
}

- (IBAction) delete {
    NSError *error = nil;
    if ([_contact destroy:&error]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error!"
                                    message:@"An error occurred deleting the object"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]
         show];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ContactInfo *entry = entries[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", entry.info];
    
    return cell;
}

@end

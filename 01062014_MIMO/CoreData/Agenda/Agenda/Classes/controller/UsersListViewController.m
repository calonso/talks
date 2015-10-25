//
//  UsersListViewController.m
//  Agenda
//
//  Created by Carlos on 29/11/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "UsersListViewController.h"
#import "AppDelegate.h"
#import "Contact.h"
#import "UserDetailsViewController.h"

@implementation UsersListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_contacts == nil) {
        NSError *error = nil;
        _contacts = [Contact list:&error];
    }
    
    if (_contacts.count > 0) {
        [self.tableView reloadData];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Warning"
                                    message:@"No results!"
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
    return [_contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Contact *contact = _contacts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.name, contact.surname];
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create the next view controller.
    UserDetailsViewController *udvc = [[UserDetailsViewController alloc] init];
    
    // Pass the selected object to the new view controller.
    udvc.contact = _contacts[indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:udvc animated:YES];
}

@end

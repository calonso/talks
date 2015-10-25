//
//  MainMenuViewController.m
//  Sensors
//
//  Created by Carlos on 18/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "MainMenuViewController.h"      
#import "AccelerometerViewController.h"
#import "GyroscopeViewController.h"
#import "MagnetometerViewController.h"
#import "ProximityViewController.h"

@implementation MainMenuViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
        // Custom initialization
        contents = @[@"Accelerometer", @"Gyroscope", @"Magnetometer", @"Proximity"];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = contents[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[AccelerometerViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[GyroscopeViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[MagnetometerViewController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[ProximityViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

@end

//
//  MapViewController.h
//  Agenda
//
//  Created by Carlos on 12/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Contact.h"
#import "MapAddressAnnotation.h"
#import "AgendaController.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, AgendaController> {
    IBOutlet MKMapView *map;
    IBOutlet UITextView *steps;
    
    CLLocationManager *locationManager;
    MapAddressAnnotation *userAnnotation;
    MapAddressAnnotation *contactAnnotation;
    
    MKRoute *routeDetails;
}

@property (nonatomic, strong) Contact *contact;

@end

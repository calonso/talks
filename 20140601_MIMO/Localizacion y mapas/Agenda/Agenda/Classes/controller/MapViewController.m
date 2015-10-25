//
//  MapViewController.m
//  Agenda
//
//  Created by Carlos on 12/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "MapViewController.h"
#import "MapAddressAnnotation.h"

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    } else {
        /*
         * Location services are not enabled.
         * Take appropriate action: for instance, prompt the user to enable the location services 
         */
        NSLog(@"Location services are not enabled");
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_contact.address
                 completionHandler:^(NSArray *placemarks, NSError *error) {
         if (placemarks.count > 0 && error == nil) {
             CLPlacemark *placemark = placemarks[0];
             contactAnnotation =
                [[MapAddressAnnotation alloc] initWithCoordinates:placemark.location.coordinate
                                                            title:_contact.name subTitle:_contact.surname];
             [map addAnnotation:contactAnnotation];
             [self displayDirections];
         } else {
             NSLog(@"Contact address could not be translated into coordinates");
         }
    }];
}

- (void) displayDirections {
    if (map.annotations.count == 2) {
        // When we have both the user's and the address' geolocations on map
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        
        MKPlacemark *source =
            [[MKPlacemark alloc] initWithCoordinate:userAnnotation.coordinate
                                  addressDictionary:nil];
        request.source = [[MKMapItem alloc] initWithPlacemark:source];
        
        
        MKPlacemark *destination =
            [[MKPlacemark alloc] initWithCoordinate:contactAnnotation.coordinate
                                  addressDictionary:nil];
        request.destination = [[MKMapItem alloc] initWithPlacemark:destination];
        
        request.transportType = MKDirectionsTransportTypeAny;
        
        /* Get the directions */
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        [directions calculateDirectionsWithCompletionHandler:
         ^(MKDirectionsResponse *response, NSError *error) {
            if (error) {
                NSLog(@"An error occurred retrieving route!");
            } else {
                routeDetails = response.routes.firstObject;
                [map addOverlay:routeDetails.polyline];
                
                NSMutableString *allSteps = [[NSMutableString alloc] init];
                for (MKRouteStep *step in routeDetails.steps) {
                    // Add all the steps to the string
                    [allSteps appendString:step.instructions];
                    [allSteps appendString:@"\n\n"];
                }
                // Show the string
                steps.text = allSteps;
                
                [map setRegion:[MapViewController regionForPoints:userAnnotation.coordinate :contactAnnotation.coordinate]
                      animated:YES];
            }
        }];
    }
}

+ (MKCoordinateRegion) regionForPoints:(CLLocationCoordinate2D)one
                                      :(CLLocationCoordinate2D)another {
    CLLocationDegrees latitude, longitude;
    CLLocationDegrees latDelta, lonDelta;
    if (one.latitude < another.latitude) {
        latDelta = another.latitude - one.latitude;
        latitude = one.latitude + latDelta / 2;
    } else {
        latDelta = one.latitude - another.latitude;
        latitude = another.latitude + latDelta / 2;
    }
    
    if (one.longitude < another.longitude) {
        lonDelta = another.longitude - one.longitude;
        longitude = one.longitude + lonDelta / 2;
    } else {
        lonDelta = one.longitude - another.longitude;
        longitude = another.longitude + lonDelta / 2;
    }
    return MKCoordinateRegionMake(
            CLLocationCoordinate2DMake(latitude, longitude),
            MKCoordinateSpanMake(latDelta * 1.5, lonDelta * 1.5));
}

#pragma mark - MKMapViewDelegate Methods

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView
           rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer =
        [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor blueColor];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // try to dequeue an existing pin view first
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    
    if (annotation == userAnnotation) {
        pinView.pinColor = MKPinAnnotationColorGreen;
    } else {
        pinView.pinColor = MKPinAnnotationColorRed;
    }
    
    return pinView;
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    /* We received the new location */
    if (userAnnotation == nil) {
        userAnnotation =
            [[MapAddressAnnotation alloc] initWithCoordinates:newLocation.coordinate
                                                        title:@"" subTitle:@""];

        [map addAnnotation:userAnnotation];
        [self displayDirections];
    } else {
        userAnnotation.coordinate = newLocation.coordinate;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    /* Failed to receive user's location */
    NSLog(@"Error: Could not retreive user's location: %@", [error localizedDescription]);
}


@end

//
//  MapAddressAnnotation.m
//  Agenda
//
//  Created by Carlos on 12/01/14.
//  Copyright (c) 2014 UPSA. All rights reserved.
//

#import "MapAddressAnnotation.h"

@implementation MapAddressAnnotation

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                     title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle {
    self = [super init];
    if (self != nil){
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
    }
    return self;
}

@end

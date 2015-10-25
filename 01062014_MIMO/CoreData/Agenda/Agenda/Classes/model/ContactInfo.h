//
//  ContactInfo.h
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface ContactInfo : NSManagedObject

@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) Contact *contact;

+ (ContactInfo *) build:(NSString *)info;

@end

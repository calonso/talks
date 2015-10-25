//
//  ContactInfo.m
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "ContactInfo.h"
#import "Contact.h"
#import "ModelHelper.h"

static NSString *ENTITY_NAME = @"ContactInfo";

@implementation ContactInfo

@dynamic info;
@dynamic contact;

+ (ContactInfo *) build:(NSString *)info {
    ContactInfo *entry = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME
                                                       inManagedObjectContext:[ModelHelper getContext]];
    entry.info = info;
    return entry;
}

@end

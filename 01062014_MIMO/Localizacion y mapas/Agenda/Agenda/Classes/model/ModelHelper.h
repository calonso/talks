//
//  ModelHelper.h
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelHelper : NSObject

+ (NSManagedObjectContext *) getContext;
+ (BOOL) saveContext:(NSError *__autoreleasing *)error;

// Errors management helper methods
+ (void)displayValidationError:(NSError *)anError;
+ (NSError *)errorFromErrors:(NSError *)firstError :(NSError *)secondError;

@end

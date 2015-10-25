//
//  Contact.m
//  Agenda
//
//  Created by Carlos on 17/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import "Contact.h"
#import "ModelHelper.h"

static NSString *ENTITY_NAME = @"Contact";

@implementation Contact

@dynamic dni;
@dynamic name;
@dynamic surname;
@dynamic address;
@dynamic infoEntries;

+ (Contact *) create:(NSString *)name :(NSString *)surname :(NSString *)dni
                    :(NSString *)address :(NSError *__autoreleasing *)error {
    // Instantiation
    // Weird NSInternalInconsistencyException if wrong name is given
    Contact *contact = [NSEntityDescription
                        insertNewObjectForEntityForName:ENTITY_NAME
                        inManagedObjectContext:[ModelHelper getContext]];
    
    if (contact) {
        // Fill data
        contact.name = name;
        contact.surname = surname;
        contact.dni = dni;
        contact.address = address;
        
        if ([ModelHelper saveContext:error]) {
            return contact;
        } else {
            // Remove the object from the context
            [[ModelHelper getContext] deleteObject:contact];
            return nil;
        }
    } else {
        NSLog(@"An error occurred creating the new contact");
        return nil;
    }
}

+ (NSArray *) list:(NSError *__autoreleasing *)error {
    // Instantiate the request for this specific entity (table)
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ENTITY_NAME];
    
    // And execute the request on the context
    return [[ModelHelper getContext] executeFetchRequest:fetchRequest error:error];
}

+ (NSArray *) query:(NSString *)name :(NSString *)surname :(NSString *)dni :(NSError *__autoreleasing *)error {
    // Instantiate the request for this specific entity (table)
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ENTITY_NAME];
    
    // Build the predicate string based on input
    NSMutableArray *fields = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:3];
    if (name && name.length > 0) {
        [fields addObject:@"name = %@"];
        [values addObject:name];
    }
    
    if (surname && surname.length > 0) {
        [fields addObject:@"surname = %@"];
        [values addObject:surname];
    }
    
    if (dni && dni.length > 0) {
        [fields addObject:@"dni = %@"];
        [values addObject:dni];
    }
    
    NSMutableString *query = [NSMutableString stringWithCapacity:128];
    for (int i = 0 ; i < fields.count ; ++i) {
        [query appendString:fields[i]];
        if (i < fields.count - 1) {
            [query appendString:@" AND "];
        }
    }
    
    // Set the desired predicate for the query
    fetchRequest.predicate = [NSPredicate predicateWithFormat:query
                                                argumentArray:values];
    
    // And execute the fetch request on the context
    return [[ModelHelper getContext] executeFetchRequest:fetchRequest error:error];
}

- (BOOL) destroy:(NSError *__autoreleasing*)error {
    [[ModelHelper getContext] deleteObject:self];
    
    return [ModelHelper saveContext:error];
}

#pragma mark - Custom validations

-(BOOL)validateDni:(id *)ioValue error:(NSError **)outError {
    /*
     * IMPORTANT!
     * The Dni is unique if no other contact with same dni is found, but
     * as the query is executed against the current context, which, in this case,
     * already has the current entity, the query should return exactly the
     * object we are validating, even if it has not been saved yet.
     * We added the object to the context in [Contact create...] method
     */
    if (*ioValue == nil || ((NSString *)*ioValue).length == 0) {
        // Simply return NO, don't add an error because bulitin validation will have added it.
        return NO;
    } else {
        NSArray *arr = [Contact query:nil :nil :(NSString *)*ioValue :outError];
        if ([arr count] == 1 && arr[0] == self) {
            return YES;
        } else {
            // Build the custom error and add to the error stream
            NSDictionary *userInfoDict = @{ NSLocalizedDescriptionKey : @"DNI is already in use" };
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain
                                                        code:NSManagedObjectValidationError
                                                    userInfo:userInfoDict];
            
            if (*outError != nil) {
                *outError = [ModelHelper errorFromErrors:error :*outError];
            } else {
                *outError = error;
            }
            return NO;
        }
    }
}

@end


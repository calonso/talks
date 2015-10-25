//
//  Contact.h
//  Agenda
//
//  Created by Carlos on 18/12/13.
//  Copyright (c) 2013 UPSA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * dni;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSSet *infoEntries;

+ (Contact *) create:(NSString *)name :(NSString *)surname
                    :(NSString *)dni :(NSString *)address
                    :(NSError *__autoreleasing *)error;
+ (NSArray *) list:(NSError *__autoreleasing *)error;
+ (NSArray *) query:(NSString *)name :(NSString *)surname :(NSString *)address :(NSError *__autoreleasing *)error;
- (BOOL) destroy:(NSError *__autoreleasing*)error;

@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)addInfoEntriesObject:(NSManagedObject *)value;
- (void)removeInfoEntriesObject:(NSManagedObject *)value;
- (void)addInfoEntries:(NSSet *)values;
- (void)removeInfoEntries:(NSSet *)values;

@end

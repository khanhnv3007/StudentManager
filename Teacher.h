//
//  Teacher.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * teacherID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSSet *teacherinClass;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addTeacherinClassObject:(NSManagedObject *)value;
- (void)removeTeacherinClassObject:(NSManagedObject *)value;
- (void)addTeacherinClass:(NSSet *)values;
- (void)removeTeacherinClass:(NSSet *)values;

@end

//
//  Student.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * studentID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSSet *studentinClass;
@property (nonatomic, retain) NSManagedObject *markofStudent;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addStudentinClassObject:(NSManagedObject *)value;
- (void)removeStudentinClassObject:(NSManagedObject *)value;
- (void)addStudentinClass:(NSSet *)values;
- (void)removeStudentinClass:(NSSet *)values;

@end

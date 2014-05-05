//
//  Subject.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * teacher;
@property (nonatomic, retain) NSString * subjectID;
@property (nonatomic, retain) NSSet *classofStudent;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addClassofStudentObject:(Student *)value;
- (void)removeClassofStudentObject:(Student *)value;
- (void)addClassofStudent:(NSSet *)values;
- (void)removeClassofStudent:(NSSet *)values;

@end

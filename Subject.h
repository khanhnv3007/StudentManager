//
//  Subject.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mark, Student, Teacher;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subjectID;
@property (nonatomic, retain) NSSet *classofStudent;
@property (nonatomic, retain) Teacher *classWithTeacher;
@property (nonatomic, retain) NSSet *subjectOfMark;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addClassofStudentObject:(Student *)value;
- (void)removeClassofStudentObject:(Student *)value;
- (void)addClassofStudent:(NSSet *)values;
- (void)removeClassofStudent:(NSSet *)values;

- (void)addSubjectOfMarkObject:(Mark *)value;
- (void)removeSubjectOfMarkObject:(Mark *)value;
- (void)addSubjectOfMark:(NSSet *)values;
- (void)removeSubjectOfMark:(NSSet *)values;


@end

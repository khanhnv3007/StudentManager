//
//  StudentModel.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "StudentModel.h"
#import "Student.h"

@implementation StudentModel

- (id)managedObject{
    Student *student = [Student MR_findFirstByAttribute:@"studentID" withValue:self.studentID];
    if (student == nil) {
        student = [Student MR_createEntity];
    }
    
    student.address = self.address;
    student.birthday = self.birthday;
    student.email = self.email;
    student.phoneNumber = self.phoneNumber;
    student.name = self.name;
    student.password = self.password;
    student.avatar = self.avatar;
    student.username = self.username;
    student.studentID = self.studentID;
    
    [student.managedObjectContext MR_saveOnlySelfAndWait];
    return student;
}

@end

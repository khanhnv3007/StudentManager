//
//  TeacherModel.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "TeacherModel.h"
#import "Teacher.h"

@implementation TeacherModel

- (id)managedObject{
    Teacher *teacher = [Teacher MR_findFirstByAttribute:@"teacherID" withValue:self.teacherID];
    if (teacher == nil) {
        teacher = [Teacher MR_createEntity];
    }
    
    teacher.name = self.name;
    teacher.password = self.password;
    teacher.teacherID = self.teacherID;
    teacher.birthday = self.birthday;
    teacher.username = self.username;
    teacher.address = self.address;
    teacher.phoneNumber = self.phoneNumber;
    teacher.email = self.email;
    teacher.avatar = self.avatar;
    
    [teacher.managedObjectContext MR_saveOnlySelfAndWait];
    return teacher;
}

@end

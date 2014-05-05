//
//  SubjectModel.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "SubjectModel.h"
#import "Subject.h"

@implementation SubjectModel

- (id)managedObject
{
    Subject *subject = [Subject MR_findFirstByAttribute:@"subjectID" withValue:self.subjectID];
    if (subject == nil) {
        subject = [Subject MR_createEntity];
    }

    subject.name = self.name;
    subject.subjectID = self.subjectID;
    subject.teacherID = self.teacherID;
    
    [subject.managedObjectContext MR_saveOnlySelfAndWait];
    return subject;
}

@end

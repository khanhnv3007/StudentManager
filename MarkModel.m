//
//  MarkModel.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "MarkModel.h"
#import "Mark.h"

@implementation MarkModel


- (id)managedObject{
    Mark *mark = [Mark MR_findFirstByAttribute:@"markID" withValue:self.markID];
    if (mark == nil) {
        mark = [Mark MR_createEntity];
    }
    
    mark.classID = self.classID;
    mark.studentID = self.studentID;
    mark.mid = self.mid;
    mark.average = self.mid;
    mark.final = self.final;
    mark.markID = self.markID;

    
    [mark.managedObjectContext MR_saveOnlySelfAndWait];
    return mark;
}

@end

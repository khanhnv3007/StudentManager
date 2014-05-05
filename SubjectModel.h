//
//  SubjectModel.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "JSONModel.h"

@interface SubjectModel : JSONModel

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * teacherID;
@property (nonatomic, strong) NSString * subjectID;
@property (nonatomic, strong) NSSet *classofStudent;

- (id)managedObject;

@end

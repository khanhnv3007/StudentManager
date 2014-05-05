//
//  DataManger.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdminModel.h"
#import "TeacherModel.h"
#import "StudentModel.h"
#import "SubjectModel.h"


@interface DataManager : NSObject

+ (DataManager *)sharedDataManager;

- (AdminModel *)createNewAdminModelWithName:(NSString *)name birthday:(NSString *)birthday email:(NSString *)email phoneNumber:(NSString *)phoneNumber address:(NSString *)address userName:(NSString *)userName password:(NSString *)password avatar:(NSString *)avatar;
- (TeacherModel *)createNewTeacherWithUserName:(NSString *)username password:(NSString *)password name:(NSString *)name birthday:(NSString *)birthday address:(NSString *)address phoneNumber:(NSString *)phoneNumber email:(NSString *)email avatar:(NSString *)avatar;
- (StudentModel *)createNewStudentWithUserName:(NSString *)username password:(NSString *)password name:(NSString *)name birthday:(NSString *)birthday address:(NSString *)address phoneNumber:(NSString *)phoneNumber email:(NSString *)email avatar:(NSString *)avatar;
- (SubjectModel *)createClassWithSubject:(NSString *)subject AndTeacher:(NSString *)teacherID;

- (NSArray *)getAllAdminAccount;
- (NSArray *)getAllStudentAccount;
- (NSArray *)getAllTeacherAccount;
- (NSArray *)getAllClass;


@end

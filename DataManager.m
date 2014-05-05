//
//  DataManger.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "DataManager.h"
#import "Admin.h"
#import "Teacher.h"
#import "Student.h"
#import "Subject.h"
#import "Mark.h"

@implementation DataManager

+ (DataManager *)sharedDataManager {
	DEFINE_SHARED_INSTANCE_USING_BLOCK ( ^{
	    return [[self alloc] init];
	});
}


- (AdminModel *)createNewAdminModelWithName:(NSString *)name birthday:(NSString *)birthday email:(NSString *)email phoneNumber:(NSString *)phoneNumber address:(NSString *)address userName:(NSString *)userName password:(NSString *)password avatar:(NSString *)avatar
{
    AdminModel *adminModel = [[AdminModel alloc] init];
    adminModel.adminID = [[Util sharedUtil] generateGUID];
    adminModel.birthday = [[Util sharedUtil] getDateFromString:birthday];
    adminModel.name = name;
    adminModel.email = email;
    adminModel.phoneNumber = phoneNumber;
    adminModel.address = address;
    adminModel.username = userName;
    adminModel.password = password;
    adminModel.avatar = avatar;
    
    return adminModel;
}

- (TeacherModel *)createNewTeacherWithUserName:(NSString *)username password:(NSString *)password name:(NSString *)name birthday:(NSString *)birthday address:(NSString *)address phoneNumber:(NSString *)phoneNumber email:(NSString *)email avatar:(NSString *)avatar
{
    TeacherModel *teacherModel = [[TeacherModel alloc] init];
    teacherModel.teacherID = [[Util sharedUtil] generateGUID];
    teacherModel.birthday = [[Util sharedUtil] getDateFromString:birthday];
    teacherModel.username = username;
    teacherModel.password = password;
    teacherModel.name = name;
    teacherModel.address = address;
    teacherModel.phoneNumber = phoneNumber;
    teacherModel.avatar= avatar;
    teacherModel.email = email;
    
    return teacherModel;
}

- (StudentModel *)createNewStudentWithUserName:(NSString *)username password:(NSString *)password name:(NSString *)name birthday:(NSString *)birthday address:(NSString *)address phoneNumber:(NSString *)phoneNumber email:(NSString *)email avatar:(NSString *)avatar
{
    StudentModel *studentModel = [[StudentModel alloc] init];
    studentModel.studentID = [[Util sharedUtil] generateGUID];
    studentModel.birthday = [[Util sharedUtil] getDateFromString:birthday];
    studentModel.username = username;
    studentModel.password = password;
    studentModel.address = address;
    studentModel.phoneNumber = phoneNumber;
    studentModel.email = email;
    studentModel.avatar = avatar;
    studentModel.name = name;
    
    return studentModel;
}

- (SubjectModel *)createClassWithSubject:(NSString *)subject AndTeacher:(NSString *)teacher
{
    SubjectModel *classModel = [[SubjectModel alloc] init];
    classModel.subjectID = [[Util sharedUtil]generateGUID];
    classModel.name = subject;
    classModel.teacher = teacher;
    return classModel;
}

- (MarkModel *)createMarkModelWithStudentID:(NSString *)studentID classID:(NSString *)classID Mid:(NSNumber *)mid Final:(NSNumber *)final Average:(NSNumber *)average
{
    MarkModel *markModel = [[MarkModel alloc] init];
    markModel.markID = [[Util sharedUtil] generateGUID];
    markModel.studentID = studentID;
    markModel.classID = classID;
    markModel.mid = mid;
    markModel.final = final;
    markModel.average = average;
    return markModel;
}

- (NSArray *)getAllAdminAccount {
	return [Admin MR_findAllSortedBy:@"name" ascending:YES];
}

- (NSArray *)getAllStudentAccount
{
    return [Student MR_findAllSortedBy:@"name" ascending:YES];
}

- (NSArray *)getAllTeacherAccount
{
    return [Teacher MR_findAllSortedBy:@"name" ascending:YES];
}

- (NSArray *)getAllClass
{
    return [Subject MR_findAllSortedBy:@"name" ascending:YES];
}

- (NSArray *)getAllMark
{
    return [Mark MR_findAllSortedBy:@"studentID" ascending:YES];
}

@end

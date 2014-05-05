//
//  AddTeacherStudentViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "AddTeacherStudentViewController.h"
#import "DataManager.h"
#import "StudentModel.h"
#import "TeacherModel.h"

@interface AddTeacherStudentViewController ()

@end

@implementation AddTeacherStudentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (IBAction)addTeacher:(id)sender {
    TeacherModel *teacherModel = [[DataManager sharedDataManager] createNewTeacherWithUserName:self.teacherUserName.text password:self.teacherUserName.text name:self.teacherName.text birthday:nil address:nil phoneNumber:nil email:nil avatar:nil];
    [teacherModel managedObject];
}
- (IBAction)addStudent:(id)sender {
    StudentModel *studentModel = [[DataManager sharedDataManager] createNewStudentWithUserName:self.studentUsername.text password:self.studentUsername.text name:self.studentName.text birthday:nil address:nil phoneNumber:nil email:nil avatar:nil];
    [studentModel managedObject];
}
@end

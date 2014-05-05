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
#import "AdminModel.h"

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

- (IBAction)addToTheList:(id)sender {
    if ([self.selectAuthor selectedSegmentIndex] == 0) {
        AdminModel *adminModel = [[DataManager sharedDataManager] createNewAdminModelWithName:self.name.text birthday:nil email:nil phoneNumber:nil address:nil userName:self.username.text password:self.username.text avatar:nil];
        [adminModel managedObject];
    }
    
    if ([self.selectAuthor selectedSegmentIndex] == 1){
        TeacherModel *teacherModel = [[DataManager sharedDataManager] createNewTeacherWithUserName:self.username.text password:self.username.text name:self.name.text birthday:nil address:nil phoneNumber:nil email:nil avatar:nil];
        [teacherModel managedObject];
    }
    
    if ([self.selectAuthor selectedSegmentIndex] == 2) {
        StudentModel *studentModel = [[DataManager sharedDataManager] createNewStudentWithUserName:self.username.text password:self.username.text name:self.name.text birthday:nil address:nil phoneNumber:nil email:nil avatar:nil];
        [studentModel managedObject];
    }
    
}
@end

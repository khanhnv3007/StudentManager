//
//  CreatePeople.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "CreatePeople.h"
#import "Student.h"
#import "Admin.h"
#import "Teacher.h"
#import "REFrostedViewController.h"

@interface CreatePeople ()

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@end

@implementation CreatePeople

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)checkusername{
    
    self.admin = [Admin MR_findFirstByAttribute:@"username" withValue:self.username.text];
	self.teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:self.username.text];
	self.student = [Student MR_findFirstByAttribute:@"username" withValue:self.username.text];
    if (self.admin == nil && self.teacher == nil && self.student == nil) {
        return YES;
    }
    return NO;
}

- (IBAction)createPeople:(id)sender {
    if ([self checkusername]) {
        if (self.selectUser.selectedSegmentIndex == 0) {
            Admin *admin = [Admin MR_createEntity];
            admin.name = self.name.text;
            admin.username = self.username.text;
            admin.password = self.username.text;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [[Util sharedUtil] showMessage:@"An admin has been created!" withTitle:@"Create Success"];
        }
        if (self.selectUser.selectedSegmentIndex == 1) {
            Teacher *teacher = [Teacher MR_createEntity];
            teacher.name = self.name.text;
            teacher.username = self.username.text;
            teacher.password = self.username.text;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [[Util sharedUtil] showMessage:@"A teacher has been created!" withTitle:@"Create Success"];
        }
        if (self.selectUser.selectedSegmentIndex == 2) {
            Student *student = [Student MR_createEntity];
            student.name = self.name.text;
            student.username = self.username.text;
            student.password = self.username.text;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [[Util sharedUtil] showMessage:@"A student has been created!" withTitle:@"Create Success"];
        }
    } else{
        [[Util sharedUtil] showMessage:@"Username is in use" withTitle:@"Create failed!"];
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}
@end

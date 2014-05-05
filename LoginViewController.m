//
//  LoginViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Admin.h"
#import "Student.h"
#import "Teacher.h"
#import "DataManager.h"

@interface LoginViewController ()

@property (nonatomic, strong) NSMutableArray *adminList;
@property (nonatomic, strong) NSMutableArray *teacherList;
@property (nonatomic, strong) NSMutableArray *studentList;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@end

@implementation LoginViewController

- (void)initial
{
    self.isAdmin = NO;
    self.isTeacher = NO;
    self.isStudent = NO;
	UIColor *mainColor = [UIColor colorWithRed:28.0 / 255 green:158.0 / 255 blue:121.0 / 255 alpha:1.0f];
	self.view.backgroundColor = mainColor;
    self.loginButton.layer.cornerRadius = 5.0f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initial];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)checkUserNameAndPassword {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	NSArray *adminAccount = [[DataManager sharedDataManager] getAllAdminAccount];
	NSArray *studentAccount = [[DataManager sharedDataManager] getAllStudentAccount];
	NSArray *teacherAccount = [[DataManager sharedDataManager] getAllTeacherAccount];
    
	self.adminList = [NSMutableArray arrayWithArray:adminAccount];
	self.studentList = [NSMutableArray arrayWithArray:studentAccount];
	self.teacherList = [NSMutableArray arrayWithArray:teacherAccount];
    
	for (Admin *admin in self.adminList) {
		if (([admin.username isEqual:self.userNameTextField.text] && [admin.password isEqual:self.passwordTextField.text])) {
			self.isAdmin = YES;
            appdelegate.username = self.userNameTextField.text;
            appdelegate.password = self.passwordTextField.text;
			return YES;
		}
	}
    
	for (Teacher *teacher in self.teacherList) {
		if ([teacher.username isEqual:self.userNameTextField.text] && [teacher.password isEqual:self.passwordTextField.text]) {
            appdelegate.username = self.userNameTextField.text;
            appdelegate.password = self.passwordTextField.text;
			NSLog(@"Teacher");
			self.isTeacher = YES;
			return YES;
		}
	}
    
	for (Student *student in self.studentList) {
		NSLog(@"User Name: %@", student.username);
		NSLog(@"Pass: %@", student.password);
		if ([student.username isEqual:self.userNameTextField.text] && [student.password isEqual:self.passwordTextField.text]) {
            appdelegate.username = self.userNameTextField.text;
            appdelegate.password = self.passwordTextField.text;
			NSLog(@"%@", student.username);
			self.isStudent = YES;
			return YES;
		}
	}
    
	if ([self.userNameTextField.text isEqualToString:@"admin"] && [self.passwordTextField.text isEqualToString:@"admin"]) {
        appdelegate.username = @"Admin";
		self.isAdmin = YES;
		return YES;
	}
    
	return NO;
}

- (void)alertWhenPasswordAndUserNameIsIncorrect {
	if (![self checkUserNameAndPassword]) {
		[[Util sharedUtil] showMessage:@"Your user name or password is incorrect" withTitle:@"Login failed"];
	}
}

- (IBAction)login:(id)sender {
    [self alertWhenPasswordAndUserNameIsIncorrect];
    if ([self checkUserNameAndPassword]) {
        NSLog(@"OK");
        [self presentViewController];
    }
}

- (void)presentViewController{
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"MenuView" bundle:nil];
    UINavigationController *navController = [nextStoryboard instantiateInitialViewController];
    self.view.window.rootViewController = navController;
    [Session sharedInstance].isAuthen = YES;
}

@end
